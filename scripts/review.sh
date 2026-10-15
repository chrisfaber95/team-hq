#!/usr/bin/env bash
# Start one fresh, headless reviewer run for a ticket's PR.
# usage: bash scripts/review.sh T-042 88
set -euo pipefail

id=${1:?usage: review.sh <ticket-id> <pr-number>}
pr=${2:?usage: review.sh <ticket-id> <pr-number>}

hq=$(cd "$(dirname "$0")/.." && pwd)
board=$hq/board
cfg() { node -e "const c=require(process.argv[1]); console.log(eval('c.'+process.argv[2]) ?? '')" "$hq/budgets.json" "$1"; }
log=$hq/logs/$id.log
mkdir -p "$hq/logs"

ticket=$(find "$board/review" -maxdepth 1 -name "$id-*.md" | head -1)
[ -n "$ticket" ] || { echo "no $id in board/review/" >&2; exit 66; }
repo=$(sed -n 's/^repo: *//p' "$ticket" | head -1 | tr -d '\r ')
repo_dir=$(cfg "repos['$repo']")
[ -n "$repo_dir" ] || { echo "ticket $id has unknown repo '$repo'" >&2; exit 64; }
# An epic PR is the whole feature against its brief (decision 0008), so it gets the larger reviewer.epic caps.
caps=reviewer; mode=""
if grep -qE "^kind: *epic" "$ticket"; then caps=reviewer.epic; mode=" This is an epic ticket: use the skill's epic review."; fi

echo "== $(date -Is) review $id PR #$pr${mode:+ (epic)}" >> "$log"
cd "$hq"
# No MCP servers and a time cap, as in dispatch.sh.
minutes=$(cfg $caps.maxMinutes)
set +e
timeout --kill-after=60 "${minutes}m" claude -p "Review ticket $id, PR #$pr in repo $repo. Use the review-pr skill (N:/team-hq/.claude/skills/review-pr/SKILL.md).$mode" \
  --agent reviewer \
  --name "reviewer-$id" \
  --model "$(cfg reviewer.model)" \
  --add-dir "$repo_dir" \
  --permission-mode auto \
  --strict-mcp-config \
  --max-turns "$(cfg $caps.maxTurns)" \
  --max-budget-usd "$(cfg $caps.maxBudgetUsd)" \
  --settings '{"crossSessionInbound":"accept"}' \
  --output-format json > "$hq/logs/$id.review.json" 2>> "$log"
rc=$?
set -e

summary=$(node -e "try{const r=require(process.argv[1]);console.log(r.subtype+' turns='+r.num_turns+' cost=\$'+(r.total_cost_usd??0).toFixed(2)+(r.is_error?' error':''))}catch{console.log('no-json-result')}" "$hq/logs/$id.review.json")
case $rc in 124|137) summary="timed out after ${minutes}m, $summary" ;; esac
echo "== $(date -Is) review exit=$rc $summary" >> "$log"
echo "$id review: exit=$rc $summary"

if [ $rc -ne 0 ] || [[ "$summary" != success* ]] || [[ "$summary" == *error* ]]; then
  echo "- [ ] $(date +%F) $id: reviewer run for PR #$pr stopped (exit $rc, $summary). Log: logs/$id.log" >> "$board/NEEDS-YOU.md"
  exit $(( rc == 0 ? 1 : rc ))
fi
