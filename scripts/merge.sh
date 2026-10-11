#!/usr/bin/env bash
# Merge a reviewed ticket's PR through the repo's git-workflow-manager agent.
# The gates are checked here, deterministically, before any agent runs:
#   - the ticket is in review/ and its last ## Review line is "round N: approve"
#   - the PR is open and every CI check passed
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
repo=$(sed -n 's/^repo: *//p' "$ticket" | head -1 | tr -d '\r ')
repo_dir=$(cfg "repos['$repo']")
[ -n "$repo_dir" ] || { echo "ticket $id has unknown repo '$repo'" >&2; exit 64; }

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

state=$(gh pr view "$pr" --repo "$(git -C "$repo_dir" remote get-url origin)" --json state -q .state)
[ "$state" = OPEN ] || escalate "PR state is $state"
checks=$(gh pr view "$pr" --repo "$(git -C "$repo_dir" remote get-url origin)" --json statusCheckRollup \
  -q '[.statusCheckRollup[] | (.conclusion // .state)] | map(select(. != "SUCCESS" and . != "NEUTRAL" and . != "SKIPPED")) | length')
total=$(gh pr view "$pr" --repo "$(git -C "$repo_dir" remote get-url origin)" --json statusCheckRollup -q '.statusCheckRollup | length')
[ "$total" -gt 0 ] && [ "$checks" = 0 ] || escalate "CI not green ($checks of $total checks not passing)"

# --- the merge, in a throwaway worktree so the user's checkout is never touched -------
wt=/n/worktrees/$repo-$id-merge
[ -e "$wt" ] || { git -C "$repo_dir" fetch -q origin && git -C "$repo_dir" worktree add -q --detach "$wt" origin/main; }

echo "== $(date -Is) merge $id PR #$pr ($verdict)" >> "$log"
cd "$wt"
# No MCP servers (the repo's Playwright server can keep claude -p from exiting) and a time cap.
set +e
timeout --kill-after=60 15m claude -p "Merge PR #$pr (ticket $id). The team reviewer approved it ('$verdict') and every CI check is green; \
both gates were verified before this run.$userok Authorized: merge it using the repo's merge convention and delete its \
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

state=$(gh pr view "$pr" --repo "$(git -C "$repo_dir" remote get-url origin)" --json state -q .state)
echo "== $(date -Is) merge exit=$rc PR state=$state" >> "$log"
[ "$state" = MERGED ] || escalate "exit $rc, PR state $state"

mv "$ticket" "$board/done/"
# The engineer's worktree is no longer needed.
ewt=/n/worktrees/$repo-$id
[ -d "$ewt" ] && git -C "$repo_dir" worktree remove --force "$ewt" || true

# Bring the user's checkout up to date: off the merged branch onto main, main fast-forwarded.
# A branch that is checked out can't be deleted, so this has to happen before the cleanup below.
head=$(gh pr view "$pr" --repo "$(git -C "$repo_dir" remote get-url origin)" --json headRefName -q .headRefName)
git -C "$repo_dir" fetch -q --prune origin
cur=$(git -C "$repo_dir" branch --show-current)
if [ "$cur" = "$head" ] || [ "$cur" = main ]; then
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
echo "$id: PR #$pr merged, ticket moved to done/"
