#!/usr/bin/env bash
# Start one capped, headless engineer run for a ticket, in its own git worktree.
# usage: bash scripts/dispatch.sh T-042 claude-dashboard [--rework]   (ids carry the repo's prefix: G-001 my-game-project)
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
. "$hq/scripts/lib/board.sh"

repo_dir=$(cfg "repos['$repo']")
[ -n "$repo_dir" ] || { echo "unknown repo '$repo' (add it to budgets.json repos)" >&2; exit 64; }
check_prefix "$id" "$repo"
repo_board=$board/$repo
wt=/n/worktrees/$repo-$id
log=$hq/logs/$id.log
# Per-repo overrides (budgets.json repoSettings, decisions 0009-0010); empty for a repo without them.
repo_setting() { cfg "repoSettings?.['$repo']?.$1"; }
export TEAM_REPO=$repo
# A repo without npm names its check; the Stop hook runs it (scripts/hooks/stop-tests.sh).
check=$(repo_setting check)
if [ -n "$check" ]; then export TEAM_CHECK=$check; fi
mkdir -p "$hq/logs" /n/worktrees

# The repo is given, so only its own board is searched (decision 0011).
repo_ticket() { find "$repo_board/$1" -maxdepth 1 -name "$id-*.md" | head -1; }
escalate() {
  local why=$1 t
  t=$(repo_ticket in-progress)
  [ -n "$t" ] && mv "$t" "$repo_board/blocked/"
  echo "- [ ] $(date +%F) $id: engineer run stopped ($why). Log: logs/$id.log" >> "$board/NEEDS-YOU.md"
  echo "$id blocked: $why" >&2
}

# --- preconditions -----------------------------------------------------------
running=$(find "$board"/*/in-progress -maxdepth 1 -name "*.md" | wc -l)
max=$(cfg maxParallel)
if [ "$running" -ge "$max" ]; then
  echo "refusing: $running tickets already in progress (maxParallel=$max)" >&2; exit 75
fi
repo_max=$(repo_setting maxParallel)
if [ -n "$repo_max" ]; then
  repo_running=$(find "$repo_board/in-progress" -maxdepth 1 -name "*.md" | wc -l)
  if [ "$repo_running" -ge "$repo_max" ]; then
    echo "refusing: $repo_running $repo tickets already in progress (repoSettings maxParallel=$repo_max)" >&2; exit 75
  fi
fi

if [ "$mode" = "--rework" ]; then
  ticket=$(repo_ticket review); [ -n "$ticket" ] || ticket=$(repo_ticket blocked)
  [ -n "$ticket" ] || { echo "no $id in board/$repo/review/ or blocked/" >&2; exit 66; }
  [ -d "$wt" ] || { echo "no worktree at $wt to rework" >&2; exit 66; }
  git -C "$wt" pull -q --ff-only || true
  task="Rework ticket $id: the reviewer requested changes. Address every open point in its ## Review section first."
else
  ticket=$(repo_ticket ready)
  [ -n "$ticket" ] || { echo "no $id in board/$repo/ready/" >&2; exit 66; }
fi
# A brief's tickets branch from and merge into its epic branch (decision 0008); the epic ticket itself is the lead's.
field() { sed -n "s/^$1: *//p" "$ticket" | head -1 | sed 's/#.*//' | tr -d '\r '; }
[ "$(field kind)" != epic ] || { echo "$id is an epic ticket: use scripts/epic.sh pr, not an engineer" >&2; exit 65; }
base=$(field base); base=${base:-main}
if [ "$mode" != "--rework" ]; then
  [ ! -e "$wt" ] || { echo "worktree $wt already exists; use --rework or remove it" >&2; exit 73; }
  git -C "$repo_dir" fetch -q origin
  git -C "$repo_dir" rev-parse -q --verify "refs/remotes/origin/$base" >/dev/null \
    || { echo "no branch $base on origin (run scripts/epic.sh open first)" >&2; exit 66; }
  git -C "$repo_dir" worktree add -q -b "team/$id" "$wt" "origin/$base"
  if [ -f "$wt/package-lock.json" ]; then
    (cd "$wt" && npm ci --no-audit --no-fund --loglevel=error)
  fi
  task="Work ticket $id."
fi
mv "$ticket" "$repo_board/in-progress/"

# A repo with an editor (decision 0010) gets its own Unreal Editor on the worktree, serving the MCP the
# run talks to. The trap stops it however the run ends, so no editor outlives the dispatch.
mcp_args=()
editor_port=$(repo_setting editor?.port)
if [ -n "$editor_port" ]; then
  editor() { (cd "$wt" && bash "$hq/scripts/unreal-editor.sh" "$1" "$repo"); }
  trap 'editor stop || true' EXIT
  { editor build && editor start; } >> "$log" 2>&1 || { escalate "the worktree's editor didn't build or start"; exit 1; }
  mcp_args=(--mcp-config "{\"mcpServers\":{\"unreal\":{\"type\":\"http\",\"url\":\"http://127.0.0.1:$editor_port/mcp\"}}}")
fi

# --- the run -------------------------------------------------------------------
prompt="$task The ticket is in N:/team-hq/board/$repo/in-progress/. Read and follow N:/team-hq/.claude/skills/engineer/SKILL.md. \
When done: open or update the PR (base branch: $base), fill the hand-off, move the ticket to review, send the session named lead one line."

echo "== $(date -Is) dispatch $id ($repo${mode:+ $mode}, base $base) in $wt" >> "$log"
cd "$wt"
# Only the editor's MCP server, if any: the repo's .mcp.json (Playwright) kept a finished run from exiting (T-036).
# The time cap ends any other hang as a failure instead of an open process.
minutes=$(repo_setting engineerMaxMinutes); minutes=${minutes:-$(cfg engineer.maxMinutes)}
set +e
timeout --kill-after=60 "${minutes}m" claude -p "$prompt" \
  --name "eng-$repo-$id" \
  --model "$(cfg engineer.model)" \
  --add-dir "$hq" \
  --permission-mode auto \
  "${mcp_args[@]}" \
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
if [ -n "$(repo_ticket in-progress)" ]; then
  escalate "run ended without moving the ticket to review/ or blocked/"; exit 1
fi
