#!/usr/bin/env bash
# Start one headless planner run: an approved brief becomes board tickets (decision 0014).
# The lead sees one summary line instead of the whole ticket-writing transcript.
# usage: bash scripts/plan.sh F-007 my-game-project
set -euo pipefail

brief_id=${1:?usage: plan.sh <F-NNN> <repo>}
repo=${2:?usage: plan.sh <F-NNN> <repo>}

hq=$(cd "$(dirname "$0")/.." && pwd)
cfg() { node -e "const c=require(process.argv[1]); console.log(eval('c.'+process.argv[2]) ?? '')" "$hq/budgets.json" "$1"; }
log=$hq/logs/$brief_id.plan.log
mkdir -p "$hq/logs"

repo_dir=$(cfg "repos['$repo']")
[ -n "$repo_dir" ] || { echo "unknown repo '$repo'" >&2; exit 64; }
brief=$(find "$hq/product/$repo/briefs" -maxdepth 1 -name "$brief_id-*.md" 2>/dev/null | head -1)
[ -n "$brief" ] || { echo "no brief $brief_id in product/$repo/briefs/" >&2; exit 66; }
status=$(sed -n 's/^status: *//p' "$brief" | head -1 | tr -d '\r ')
[ "$status" = approved ] || { echo "$brief_id is '$status', only approved briefs are planned" >&2; exit 65; }

echo "== $(date -Is) plan $brief_id ($repo)" >> "$log"
cd "$hq"
minutes=$(cfg planner.maxMinutes)
set +e
timeout --kill-after=60 "${minutes}m" claude -p "Plan brief $brief_id for repo $repo. The brief is $brief. Follow your agent instructions." \
  --agent planner \
  --name "planner-$brief_id" \
  --model "$(cfg planner.model)" \
  --add-dir "$repo_dir" \
  --permission-mode auto \
  --strict-mcp-config \
  --disable-slash-commands \
  --max-turns "$(cfg planner.maxTurns)" \
  --max-budget-usd "$(cfg planner.maxBudgetUsd)" \
  --settings '{"crossSessionInbound":"accept"}' \
  --output-format json > "$hq/logs/$brief_id.plan.json" 2>> "$log"
rc=$?
set -e

summary=$(node -e "try{const r=require(process.argv[1]);console.log(r.subtype+' turns='+r.num_turns+' cost=\$'+(r.total_cost_usd??0).toFixed(2)+(r.is_error?' error':'')+' | '+String(r.result||'').split('\n').pop())}catch{console.log('no-json-result')}" "$hq/logs/$brief_id.plan.json")
case $rc in 124|137) summary="timed out after ${minutes}m, $summary" ;; esac
echo "== $(date -Is) plan exit=$rc $summary" >> "$log"
echo "$brief_id plan: exit=$rc $summary"

if [ $rc -ne 0 ] || [[ "$summary" != success* ]] || [[ "$summary" == *error* ]]; then
  echo "- [ ] $(date +%F) $brief_id: planner run stopped (exit $rc, $summary). Log: logs/$brief_id.plan.log" >> "$hq/board/NEEDS-YOU.md"
  exit $(( rc == 0 ? 1 : rc ))
fi
