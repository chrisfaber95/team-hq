#!/usr/bin/env bash
# Merge a reviewed ticket's PR through the repo's git-workflow-manager agent.
# The gates are checked here, deterministically, before any agent runs:
#   - the ticket is in review/ and its last ## Review line is "round N: approve"
#   - the PR is open, targets the ticket's base: (default main), and every CI check passed
#   - epic tickets (decision 0008): every other ticket of the brief is done, and user_ok: true
#     when the brief has user_check: true
# usage: bash scripts/merge.sh T-042 88
set -euo pipefail

id=${1:?usage: merge.sh <ticket-id> <pr-number>}
pr=${2:?usage: merge.sh <ticket-id> <pr-number>}

hq=$(cd "$(dirname "$0")/.." && pwd)
board=$hq/board
cfg() { node -e "const c=require(process.argv[1]); console.log(eval('c.'+process.argv[2]) ?? '')" "$hq/budgets.json" "$1"; }
log=$hq/logs/$id.log
mkdir -p "$hq/logs" /n/worktrees
escalate() { echo "- [ ] $(date +%F) $id: merge of PR #$pr stopped ($1). Log: logs/$id.log" >> "$board/NEEDS-YOU.md"; echo "$id merge refused: $1" >&2; exit 1; }

ticket=$(find "$board/review" -maxdepth 1 -name "$id-*.md" | head -1)
[ -n "$ticket" ] || { echo "no $id in board/review/" >&2; exit 66; }
field() { sed -n "s/^$1: *//p" "$ticket" | head -1 | sed 's/#.*//' | tr -d '\r '; }
repo=$(field repo)
repo_dir=$(cfg "repos['$repo']")
[ -n "$repo_dir" ] || { echo "ticket $id has unknown repo '$repo'" >&2; exit 64; }
base=$(field base); base=${base:-main}
kind=$(field kind); kind=${kind:-ticket}
origin=$(git -C "$repo_dir" remote get-url origin)

# --- gates ----------------------------------------------------------------------
# A reviewer sometimes copies the lead's bullet style ("- round 2: approve"); the verdict is the same.
verdict=$(sed -n '/^## Review/,/^## /p' "$ticket" | sed -E 's/^- (round [0-9]+:)/\1/' | grep -E '^round [0-9]+:' | tail -1 | tr -d '\r')
[[ "$verdict" =~ ^round\ [0-9]+:\ approve ]] || escalate "last review verdict is '${verdict:-none}', not approve"

labels=$(sed -n 's/^labels: *//p' "$ticket" | head -1 | sed 's/#.*//' | tr -d '\r')
userok=""
if printf "%s" "$labels" | grep -qE "auth|deps|contract|migration"; then
  grep -qE "^user_ok: *true" "$ticket" || escalate "high-risk labels $labels: set user_ok: true in the ticket to allow the merge"
  userok=" The user explicitly approved this merge by setting user_ok: true in the ticket (labels: $labels)."
fi

# An epic merges the whole feature into main: all of the brief's tickets first, and the user's check if the brief asks for it.
how="using the repo's merge convention"
if [ "$kind" = epic ]; then
  brief=$(field brief)
  open_children=$(grep -lE "^brief: *$brief\b" "$board"/{backlog,ready,in-progress,review,blocked}/*.md 2>/dev/null \
    | grep -v "/$id-" | xargs -r -n1 basename | sed 's/\.md$//' | tr '\n' ' ' || true)
  [ -z "$open_children" ] || escalate "epic $brief still has tickets that are not done: $open_children"
  brief_file=$(find "$hq/product/briefs" -maxdepth 1 -name "$brief-*.md" | head -1)
  if [ -n "$brief_file" ] && grep -qE "^user_check: *true" "$brief_file"; then
    grep -qE "^user_ok: *true" "$ticket" || escalate "brief $brief asks for your check: try $(field branch), then set user_ok: true in the ticket"
    userok="$userok The user checked the feature and set user_ok: true in the ticket."
  fi
  how="with a merge commit, not a squash, so main keeps one commit per ticket"
fi

state=$(gh pr view "$pr" --repo "$origin" --json state -q .state)
[ "$state" = OPEN ] || escalate "PR state is $state"
pr_base=$(gh pr view "$pr" --repo "$origin" --json baseRefName -q .baseRefName)
[ "$pr_base" = "$base" ] || escalate "PR targets $pr_base, the ticket's base is $base"
checks=$(gh pr view "$pr" --repo "$origin" --json statusCheckRollup \
  -q '[.statusCheckRollup[] | (.conclusion // .state)] | map(select(. != "SUCCESS" and . != "NEUTRAL" and . != "SKIPPED")) | length')
total=$(gh pr view "$pr" --repo "$origin" --json statusCheckRollup -q '.statusCheckRollup | length')
[ "$total" -gt 0 ] && [ "$checks" = 0 ] || escalate "CI not green ($checks of $total checks not passing)"

# --- the merge, in a throwaway worktree so the user's checkout is never touched -------
wt=/n/worktrees/$repo-$id-merge
[ -e "$wt" ] || { git -C "$repo_dir" fetch -q origin && git -C "$repo_dir" worktree add -q --detach "$wt" "origin/$base"; }

echo "== $(date -Is) merge $id PR #$pr into $base ($verdict)" >> "$log"
cd "$wt"
# No MCP servers (the repo's Playwright server can keep claude -p from exiting) and a time cap.
set +e
timeout --kill-after=60 15m claude -p "Merge PR #$pr (ticket $id) into $base. The team reviewer approved it ('$verdict') and every CI check is green; \
both gates were verified before this run.$userok Authorized: merge it $how and delete its \
remote branch. Do nothing else: no new commits, no release. Report the merge commit." \
  --agent git-workflow-manager \
  --name "merge-$id" \
  --model sonnet \
  --permission-mode auto \
  --strict-mcp-config \
  --max-turns 20 \
  --max-budget-usd 1 \
  --settings "$hq/.claude/merger.settings.json" \
  --output-format json > "$hq/logs/$id.merge.json" 2>> "$log"
rc=$?
set -e
cd "$hq"
git -C "$repo_dir" worktree remove --force "$wt" || true

state=$(gh pr view "$pr" --repo "$origin" --json state -q .state)
echo "== $(date -Is) merge exit=$rc PR state=$state" >> "$log"
[ "$state" = MERGED ] || escalate "exit $rc, PR state $state"

mv "$ticket" "$board/done/"
# The engineer's worktree is no longer needed.
ewt=/n/worktrees/$repo-$id
[ -d "$ewt" ] && git -C "$repo_dir" worktree remove --force "$ewt" || true

# Bring the user's checkout up to date: off the merged branch onto main, main fast-forwarded.
# A branch that is checked out can't be deleted, so this has to happen before the cleanup below.
# A merge into an epic branch leaves main and the user's checkout alone.
head=$(gh pr view "$pr" --repo "$origin" --json headRefName -q .headRefName)
git -C "$repo_dir" fetch -q --prune origin
cur=$(git -C "$repo_dir" branch --show-current)
if [ "$base" != main ]; then
  [ "$cur" != "$head" ] || echo "warning: $repo_dir is on the merged branch $head; switch it yourself" >&2
elif [ "$cur" = "$head" ] || [ "$cur" = main ]; then
  if [ -z "$(git -C "$repo_dir" status --porcelain)" ]; then
    git -C "$repo_dir" switch -q main && git -C "$repo_dir" merge -q --ff-only origin/main \
      || echo "warning: could not fast-forward main in $repo_dir" >&2
  else
    echo "warning: $repo_dir has uncommitted changes; left it on $cur" >&2
  fi
else
  git -C "$repo_dir" fetch -q origin main:main 2>/dev/null || echo "warning: local main in $repo_dir not fast-forwarded" >&2
fi
for b in "$head" "team/$id"; do git -C "$repo_dir" branch -D "$b" >/dev/null 2>&1 || true; done
echo "$id: PR #$pr merged into $base, ticket moved to done/"
