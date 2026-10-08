#!/usr/bin/env bash
# Stop hook for engineer sessions (registered in .claude/engineer.settings.json).
# Refuses to let the run end while the repo's checks fail, so red work is never handed off.
# Skips when only docs changed, and never blocks twice in a row (stop_hook_active).
input=$(cat)
active=$(printf '%s' "$input" | node -e "let s='';process.stdin.on('data',d=>s+=d).on('end',()=>{try{console.log(JSON.parse(s).stop_hook_active?1:0)}catch{console.log(0)}})")
[ "$active" = 1 ] && exit 0

git rev-parse --git-dir >/dev/null 2>&1 || exit 0
base=$(git merge-base HEAD origin/main 2>/dev/null) || exit 0
changed=$( { git diff --name-only "$base"; git ls-files --others --exclude-standard; } | sort -u)
# Docs-only changes (Markdown, docs/, .claude/) skip the checks, as the repo's own rules say.
code=$(printf '%s\n' "$changed" | grep -vE '(\.md$|^docs/|^\.claude/)' | grep -v '^$')
[ -z "$code" ] && exit 0

if [ -n "$TEAM_CHECK" ]; then
  check=$TEAM_CHECK
elif [ -f package.json ]; then
  check="npm test"
  node -e "process.exit(require('./package.json').scripts?.typecheck?0:1)" && check="npm run typecheck && npm test"
else
  exit 0
fi

out=$(bash -c "$check" 2>&1) && exit 0
{
  echo "Checks failed ($check). Fix them before handing off; the run can't end while they fail."
  printf '%s\n' "$out" | tail -40
} >&2
exit 2
