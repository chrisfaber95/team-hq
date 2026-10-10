#!/usr/bin/env bash
# Start one capped, headless engineer run for a ticket, in its own git worktree.
# usage: bash scripts/dispatch.sh T-042 claude-dashboard [--rework]
#   --rework  re-run on the existing worktree/branch after "changes requested"
#             (ticket is taken from review/ or blocked/ back to in-progress/)
# Exit code: the engineer run's; non-zero means the ticket was moved to blocked/.
set -euo pipefail

id=${1:?usage: dispatch.sh <ticket-id> <repo> [--rework]}
repo=${2:?usage: dispatch.sh <ticket-id> <repo> [--rework]}
mode=${3:-}

hq=$(cd "$(dirname "$0")/.." && pwd)
board=$hq/board
cfg() { node -e "const c=require(process.argv[1]); console.log(eval('c.'+process.argv[2]) ?? '')" "$hq/budgets.json" "$1"; }

repo_dir=$(cfg "repos['$repo']")
[ -n "$repo_dir" ] || { echo "unknown repo '$repo' (add it to budgets.json repos)" >&2; exit 64; }
wt=/n/worktrees/$repo-$id
log=$hq/logs/$id.log
mkdir -p "$hq/logs" /n/worktrees

find_ticket() { find "$board/$1" -maxdepth 1 -name "$id-*.md" | head -1; }
escalate() {
  local why=$1 t
  t=$(find_ticket in-progress)
  [ -n "$t" ] && mv "$t" "$board/blocked/"
  echo "- [ ] $(date +%F) $id: engineer run stopped ($why). Log: logs/$id.log" >> "$board/NEEDS-YOU.md"
  echo "$id blocked: $why" >&2
}

# --- preconditions -----------------------------------------------------------
running=$(find "$board/in-progress" -maxdepth 1 -name "*.md" | wc -l)
max=$(cfg maxParallel)
if [ "$running" -ge "$max" ]; then
  echo "refusing: $running tickets already in progress (maxParallel=$max)" >&2; exit 75
fi

if [ "$mode" = "--rework" ]; then
  ticket=$(find_ticket review); [ -n "$ticket" ] || ticket=$(find_ticket blocked)
  [ -n "$ticket" ] || { echo "no $id in review/ or blocked/" >&2; exit 66; }
  [ -d "$wt" ] || { echo "no worktree at $wt to rework" >&2; exit 66; }
  git -C "$wt" pull -q --ff-only || true
  task="Rework ticket $id: the reviewer requested changes. Address every open point in its ## Review section first."
else
  ticket=$(find_ticket ready)
  [ -n "$ticket" ] || { echo "no $id in board/ready/" >&2; exit 66; }
  [ ! -e "$wt" ] || { echo "worktree $wt already exists; use --rework or remove it" >&2; exit 73; }
  git -C "$repo_dir" fetch -q origin
  git -C "$repo_dir" worktree add -q -b "team/$id" "$wt" origin/main
  if [ -f "$wt/package-lock.json" ]; then
    (cd "$wt" && npm ci --no-audit --no-fund --loglevel=error)
  fi
  task="Work ticket $id."
fi
mv "$ticket" "$board/in-progress/"

# --- the run -------------------------------------------------------------------
prompt="$task The ticket is in N:/team-hq/board/in-progress/. Read and follow N:/team-hq/.claude/skills/engineer/SKILL.md. \
When done: open or update the PR, fill the hand-off, move the ticket to review, send the session named lead one line."

echo "== $(date -Is) dispatch $id ($repo${mode:+ $mode}) in $wt" >> "$log"
cd "$wt"
# No MCP servers: the repo's .mcp.json (Playwright) kept a finished run from exiting (T-036).
# The time cap ends any other hang as a failure instead of an open process.
minutes=$(cfg engineer.maxMinutes)
set +e
timeout --kill-after=60 "${minutes}m" claude -p "$prompt" \
  --name "eng-$repo-$id" \
  --model "$(cfg engineer.model)" \
  --add-dir "$hq" \
  --permission-mode auto \
  --strict-mcp-config \
  --max-turns "${ENG_MAX_TURNS:-$(cfg engineer.maxTurns)}" \
  --max-budget-usd "$(cfg engineer.maxBudgetUsd)" \
  --settings "$hq/.claude/engineer.settings.json" \
  --output-format json > "$hq/logs/$id.json" 2>> "$log"
rc=$?
set -e

# One summary line per run: turns, cost, outcome (subtype is "success" or an error_* reason).
summary=$(node -e "try{const r=require(process.argv[1]);console.log(r.subtype+' turns='+r.num_turns+' cost=\$'+(r.total_cost_usd??0).toFixed(2)+(r.is_error?' error':''))}catch{console.log('no-json-result')}" "$hq/logs/$id.json")
case $rc in 124|137) summary="timed out after ${minutes}m, $summary" ;; esac
echo "== $(date -Is) exit=$rc $summary" >> "$log"
echo "$id: exit=$rc $summary"

if [ $rc -ne 0 ] || [[ "$summary" != success* ]] || [[ "$summary" == *error* ]]; then
  escalate "exit $rc, $summary"; exit $(( rc == 0 ? 1 : rc ))
fi
if [ -n "$(find_ticket in-progress)" ]; then
  escalate "run ended without moving the ticket to review/ or blocked/"; exit 1
fi
