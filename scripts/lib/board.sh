# Board lookups shared by the scripts (decision 0011): one board per repo, board/<repo>/<stage>/<id>-<slug>.md.
# Ids carry the repo's prefix (budgets.json repoSettings.<repo>.prefix), so an id is unique across all boards.
# Source it after setting $board and defining cfg.

# The first ticket file for an id in any repo board's given stages, or nothing.
# usage: find_ticket <id> <stage>...
find_ticket() {
  local id=$1 stage; shift
  for stage in "$@"; do
    find "$board"/*/"$stage" -maxdepth 1 -name "$id-*.md" 2>/dev/null | head -1 | grep . && return 0
  done
  return 0
}

# The repo board a ticket file lives in (board/<repo>), for moves within it.
ticket_board() { dirname "$(dirname "$1")"; }

# Refuses an id without the repo's prefix (T-042 for claude-dashboard, G-001 for my-game-project).
check_prefix() {
  local id=$1 repo=$2 prefix
  prefix=$(cfg "repoSettings?.['$repo']?.prefix")
  [ -n "$prefix" ] || { echo "repo '$repo' has no prefix (add it to budgets.json repoSettings)" >&2; exit 64; }
  [[ "$id" == "$prefix"-* ]] || { echo "$id is not a $repo ticket (its ids start with $prefix-)" >&2; exit 64; }
}
