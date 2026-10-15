#!/usr/bin/env bash
# Epic branches: one branch per product brief, merged into main once the feature is complete (decision 0008).
# usage: bash scripts/epic.sh open F-007 claude-dashboard
#          push epic/F-007 from origin/main; the brief's child tickets branch from it and merge into it
#        bash scripts/epic.sh pr T-094
#          once every child ticket is in done/: bring main into the epic and open the PR epic -> main
#          (through the repo's git-workflow-manager, no merge), set pr: and move the epic ticket to review/
set -euo pipefail

cmd=${1:?usage: epic.sh open <brief-id> <repo> | epic.sh pr <epic-ticket-id>}

hq=$(cd "$(dirname "$0")/.." && pwd)
board=$hq/board
cfg() { node -e "const c=require(process.argv[1]); console.log(eval('c.'+process.argv[2]) ?? '')" "$hq/budgets.json" "$1"; }
field() { sed -n "s/^$1: *//p" "$2" | head -1 | sed 's/#.*//' | tr -d '\r '; }
repo_path() {
  local dir; dir=$(cfg "repos['$1']")
  [ -n "$dir" ] || { echo "unknown repo '$1' (add it to budgets.json repos)" >&2; exit 64; }
  echo "$dir"
}

open_epic() {
  local brief=${1:?usage: epic.sh open <brief-id> <repo>} repo=${2:?usage: epic.sh open <brief-id> <repo>}
  local repo_dir branch=epic/$1
  repo_dir=$(repo_path "$repo")
  git -C "$repo_dir" fetch -q origin
  if git -C "$repo_dir" rev-parse -q --verify "refs/remotes/origin/$branch" >/dev/null; then
    echo "$branch already exists on origin"; return 0
  fi
  git -C "$repo_dir" push -q origin "refs/remotes/origin/main:refs/heads/$branch"
  echo "$brief: $branch pushed from origin/main"
}

open_pr() {
  local id=${1:?usage: epic.sh pr <epic-ticket-id>}
  local ticket stage log
  for stage in backlog ready blocked; do
    ticket=$(find "$board/$stage" -maxdepth 1 -name "$id-*.md" | head -1)
    [ -n "$ticket" ] && break
  done
  [ -n "$ticket" ] || { echo "no $id in board/backlog/, ready/ or blocked/" >&2; exit 66; }
  [ "$(field kind "$ticket")" = epic ] || { echo "$id is not an epic ticket (kind: epic)" >&2; exit 65; }

  local brief branch repo repo_dir
  brief=$(field brief "$ticket"); branch=$(field branch "$ticket"); repo=$(field repo "$ticket")
  [ -n "$brief" ] && [ -n "$branch" ] || { echo "$id needs brief: and branch: in its front matter" >&2; exit 65; }
  repo_dir=$(repo_path "$repo")
  log=$hq/logs/$id.log
  mkdir -p "$hq/logs" /n/worktrees
  escalate() {
    local t; t=$(find "$board/backlog" "$board/ready" -maxdepth 1 -name "$id-*.md" | head -1)
    [ -n "$t" ] && mv "$t" "$board/blocked/"
    echo "- [ ] $(date +%F) $id: epic PR for $branch stopped ($1). Log: logs/$id.log" >> "$board/NEEDS-YOU.md"
    echo "$id blocked: $1" >&2; exit 1
  }

  # --- gate: every other ticket of the brief is merged into the epic ---------------
  local open_children
  open_children=$(grep -lE "^brief: *$brief\b" "$board"/{backlog,ready,in-progress,review,blocked}/*.md 2>/dev/null \
    | grep -v "/$id-" | xargs -r -n1 basename | sed 's/\.md$//' | tr '\n' ' ' || true)
  [ -z "$open_children" ] || { echo "refusing: $brief tickets not done yet: $open_children" >&2; exit 75; }

  local merged
  merged=$(grep -lE "^brief: *$brief\b" "$board"/done/*.md 2>/dev/null | while read -r t; do
    echo "- $(basename "$t" .md) (PR #$(field pr "$t"))"; done || true)
  [ -n "$merged" ] || { echo "refusing: no $brief tickets in done/" >&2; exit 75; }

  local brief_file title
  brief_file=$(find "$hq/product/briefs" -maxdepth 1 -name "$brief-*.md" | head -1)
  title=$(sed -n 's/^# *//p' "${brief_file:-/dev/null}" | head -1 | tr -d '\r')

  # --- bring main in and open the PR, in a throwaway worktree on the epic branch -----
  git -C "$repo_dir" fetch -q origin
  git -C "$repo_dir" rev-parse -q --verify "refs/remotes/origin/$branch" >/dev/null \
    || escalate "$branch does not exist on origin (run epic.sh open first)"
  local wt=/n/worktrees/$repo-$id
  [ -e "$wt" ] || git -C "$repo_dir" worktree add -q -B "$branch" "$wt" "origin/$branch"

  echo "== $(date -Is) epic pr $id ($branch -> main)" >> "$log"
  cd "$wt"
  set +e
  timeout --kill-after=60 15m claude -p "Open the pull request for epic branch $branch (ticket $id, brief $brief: ${title:-$brief}). \
1) If origin/main is not already contained in $branch, merge origin/main into $branch with a merge commit and push it. \
If that merge has conflicts, abort it and report the conflicting files; do not resolve them. \
2) Open a PR from $branch into main titled '$brief: ${title:-epic}'. Body: the feature in one sentence, then these merged tickets: \
$(echo "$merged" | tr '\n' ';') Note in the body that it must be merged with a merge commit, not squashed. \
Don't merge it. Do nothing else. Report the PR number." \
    --agent git-workflow-manager \
    --name "epic-$id" \
    --model sonnet \
    --permission-mode auto \
    --strict-mcp-config \
    --max-turns 25 \
    --max-budget-usd 1 \
    --settings "$hq/.claude/epic.settings.json" \
    --output-format json > "$hq/logs/$id.epic.json" 2>> "$log"
  local rc=$?
  set -e
  cd "$hq"
  git -C "$repo_dir" worktree remove --force "$wt" || true

  local origin pr
  origin=$(git -C "$repo_dir" remote get-url origin)
  pr=$(gh pr list --repo "$origin" --head "$branch" --base main --state open --json number -q '.[0].number')
  echo "== $(date -Is) epic pr exit=$rc pr=${pr:-none}" >> "$log"
  [ -n "$pr" ] || escalate "exit $rc, no open PR from $branch into main"
  git -C "$repo_dir" fetch -q origin
  git -C "$repo_dir" merge-base --is-ancestor origin/main "origin/$branch" || escalate "PR #$pr is open but $branch is behind main"

  sed -i "s/^pr:.*/pr: $pr/" "$ticket"
  mv "$ticket" "$board/review/"
  echo "$id: PR #$pr ($branch -> main) open, ticket moved to review/; next: bash scripts/review.sh $id $pr"
}

case $cmd in
  open) shift; open_epic "$@" ;;
  pr) shift; open_pr "$@" ;;
  *) echo "usage: epic.sh open <brief-id> <repo> | epic.sh pr <epic-ticket-id>" >&2; exit 64 ;;
esac
