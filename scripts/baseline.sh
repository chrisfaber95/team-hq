#!/usr/bin/env bash
# Phase 0 baseline: one ordinary Claude Code session per ticket (no team rules, the repo's normal
# workflow via git-workflow-manager, but it stops at an open PR: merging goes through the team
# reviewer + scripts/merge.sh gates), measured from the headless JSON result.
# usage: bash scripts/baseline.sh <repo> T-002 [T-003 ...]
set -uo pipefail

repo=${1:?usage: baseline.sh <repo> <ticket-id>...}; shift
hq=$(cd "$(dirname "$0")/.." && pwd)
board=$hq/board
repo_board=$board/$repo
repo_dir=$(node -e "console.log(require(process.argv[1]).repos[process.argv[2]] ?? '')" "$hq/budgets.json" "$repo")
[ -n "$repo_dir" ] || { echo "unknown repo $repo" >&2; exit 64; }
origin=$(git -C "$repo_dir" remote get-url origin)
mkdir -p "$hq/logs" /n/worktrees

for id in "$@"; do
  ticket=$(find "$repo_board/ready" -maxdepth 1 -name "$id-*.md" | head -1)
  [ -n "$ticket" ] || { echo "$id: not in board/$repo/ready/, skipped"; continue; }
  mv "$ticket" "$repo_board/in-progress/"; ticket=$repo_board/in-progress/$(basename "$ticket")

  wt=/n/worktrees/$repo-baseline-$id
  git -C "$repo_dir" fetch -q origin
  [ -e "$wt" ] || git -C "$repo_dir" worktree add -q --detach "$wt" origin/main
  if [ -f "$wt/package-lock.json" ]; then
    (cd "$wt" && npm ci --no-audit --no-fund --loglevel=error >/dev/null)
  fi

  start=$(date +%s)
  echo "== $(date -Is) baseline $id in $wt" >> "$hq/logs/$id.log"
  (cd "$wt" && claude -p "Work the ticket in $(cygpath -m "$ticket") the way you normally work in this repo, \
following this repo's CLAUDE.md, including its Git section: delegate commit, push and opening the PR to \
git-workflow-manager, with the restriction \"don't merge\". Put the ticket id in the PR title ('$id: ...'). When the \
PR is open, set pr: in the ticket front matter and write a short '## Hand-off' in the ticket file (what changed, PR link). If you can't finish, write '## Blocked' in the ticket with why." \
    --name "baseline-$id" \
    --add-dir "$hq" \
    --permission-mode auto \
    --max-turns 150 \
    --max-budget-usd 5 \
    --output-format json > "$hq/logs/$id.baseline.json" 2>> "$hq/logs/$id.log")
  rc=$?
  secs=$(( $(date +%s) - start ))

  pr=$(gh pr list --repo "$origin" --state all --search "$id in:title" --json number,state -q '.[0] | "\(.number) \(.state)"')
  row=$(node -e "
    const r=require(process.argv[1]); const u=r.usage||{};
    const inp=(u.input_tokens||0)+(u.cache_creation_input_tokens||0)+(u.cache_read_input_tokens||0);
    const cache=inp? Math.round(100*(u.cache_read_input_tokens||0)/inp):0;
    const [n,st]=(process.argv[3]||' ').split(' ');
    console.log('| '+process.argv[2]+' | '+(n?'#'+n+' '+st:'none')+' | baseline-'+process.argv[2]+' ('+r.num_turns+' turns, '+r.subtype+') | '
      +inp+' ('+cache+'% cache) | '+(u.output_tokens||0)+' | '+(r.total_cost_usd||0).toFixed(2)+' | '+Math.round(process.argv[4]/60)+' min | |');
  " "$hq/logs/$id.baseline.json" "$id" "$pr" "$secs" 2>/dev/null || echo "| $id | ${pr:-none} | baseline-$id (no result) | | | | $((secs/60)) min | exit $rc |")
  echo "$row"
  echo "== $(date -Is) baseline $id exit=$rc pr=$pr ${secs}s" >> "$hq/logs/$id.log"
  # Replace the empty row for this ticket in metrics/baseline.md.
  node -e "
    const fs=require('fs');const f=process.argv[1];const L=fs.readFileSync(f,'utf8').split('\n');
    const key='| '+process.argv[2]+' |';
    const i=L.findIndex(l=>l.startsWith(key)&&/^[ |\r]*$/.test(l.slice(key.length)));
    if(i>=0){L[i]=process.argv[3];fs.writeFileSync(f,L.join('\n'));}
  " "$hq/metrics/baseline.md" "$id" "$row"

  if [[ "$pr" == *OPEN || "$pr" == *MERGED ]]; then mv "$ticket" "$repo_board/review/"; else mv "$ticket" "$repo_board/blocked/"
    echo "- [ ] $(date +%F) $id: baseline run ended without a PR (exit $rc, PR ${pr:-none}). Log: logs/$id.log" >> "$board/NEEDS-YOU.md"; fi
  git -C "$repo_dir" worktree remove --force "$wt" 2>/dev/null || true
done
