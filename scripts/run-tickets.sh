#!/usr/bin/env bash
# Run tickets of one repo end to end, in order: dispatch -> review -> rework (up to the round cap) -> merge.
# The lead starts it once (run_in_background) and is woken once, when every ticket merged or one needs the
# lead or the user, instead of once per step (decision 0014). The step scripts stay the only place that runs
# claude, checks gates and writes NEEDS-YOU.md; this file only chains them and keeps the board committed.
# usage: bash scripts/run-tickets.sh <repo> <id>...      e.g. run-tickets.sh my-game-project G-046 G-048
#   backlog/  moves to ready/ when every depends_on is in done/, otherwise STOP
#   ready/    dispatch;  review/  resume (merge an approve, rework a "changes" not yet reworked, else review)
#   done/     skipped;   in-progress/ or blocked/  STOP (the lead decides)
# Output: one line per finished ticket, and a final DONE or STOP line. Exit 0 only when every ticket merged.
set -euo pipefail

repo=${1:?usage: run-tickets.sh <repo> <id>...}; shift
[ $# -gt 0 ] || { echo "usage: run-tickets.sh <repo> <id>..." >&2; exit 64; }

hq=$(cd "$(dirname "$0")/.." && pwd)
cfg() { node -e "const c=require(process.argv[1]); console.log(eval('c.'+process.argv[2]) ?? '')" "$hq/budgets.json" "$1"; }
repo_board=$hq/board/$repo
[ -d "$repo_board" ] || { echo "no board for '$repo' (board/$repo)" >&2; exit 64; }
max_rounds=$(cfg reviewer.maxRounds)

ticket_file() { find "$repo_board"/*/ -maxdepth 1 -name "$1-*.md" 2>/dev/null | head -1; }
stage_of() { local t; t=$(ticket_file "$1"); if [ -n "$t" ]; then basename "$(dirname "$t")"; else echo none; fi; }
field() { sed -n "s/^$2: *//p" "$1" | head -1 | sed 's/#.*//' | tr -d '\r '; }
# The last "round N: ..." line of ## Review (merge.sh reads it the same way).
verdict() { sed -n '/^## Review/,/^## /p' "$1" | sed -E 's/^- (round [0-9]+:)/\1/' | grep -E '^round [0-9]+:' | tail -1 | tr -d '\r' || true; }
is_approve() { [[ "$1" =~ ^round\ [0-9]+:\ *approve ]]; }
commit_board() {
  git -C "$hq" add board >/dev/null 2>&1 || return 0
  git -C "$hq" commit -q -m "board: $1" -m "Co-Authored-By: Claude <noreply@anthropic.com>" >/dev/null 2>&1 || true
}
stop() { echo "STOP $1: $2"; commit_board "$1 stopped ($2)"; exit "${3:-1}"; }

for id in "$@"; do
  st=$(stage_of "$id")
  case $st in
    done) echo "$id: already done"; continue ;;
    none) stop "$id" "no ticket in board/$repo" 66 ;;
    in-progress|blocked) stop "$id" "ticket is in $st/, the lead decides" ;;
    backlog)
      t=$(ticket_file "$id")
      for dep in $(sed -n 's/^depends_on: *\[\(.*\)\].*/\1/p' "$t" | head -1 | tr -d ' \r' | tr ',' ' '); do
        if [ "$(stage_of "$dep")" != done ]; then stop "$id" "depends on $dep, which is not done"; fi
      done
      mv "$t" "$repo_board/ready/"; st=ready ;;
  esac

  # next: dispatch | review | rework | merge
  if [ "$st" = ready ]; then
    next=dispatch
  else
    # Resuming a ticket in review/: an approve merges; a "changes" verdict with fewer rework runs than
    # "changes" rounds still needs its rework; anything else needs a review.
    t=$(ticket_file "$id"); v=$(verdict "$t")
    changes=$(sed -n '/^## Review/,/^## /p' "$t" | grep -cE '^-? *round [0-9]+: *changes' || true)
    reworks=$(grep -cE "^== .* dispatch $id \(.*--rework" "$hq/logs/$id.log" 2>/dev/null || true)
    if is_approve "$v"; then next=merge
    elif [ "${changes:-0}" -gt "${reworks:-0}" ]; then next=rework
    else next=review; fi
  fi

  while :; do
    case $next in
      dispatch)
        bash "$hq/scripts/dispatch.sh" "$id" "$repo" || stop "$id" "engineer run stopped, see NEEDS-YOU.md" $?
        next=review ;;
      rework)
        rounds=$(field "$(ticket_file "$id")" review_rounds)
        if [ "${rounds:-0}" -ge "$max_rounds" ]; then stop "$id" "review round cap ($max_rounds) reached"; fi
        bash "$hq/scripts/dispatch.sh" "$id" "$repo" --rework || stop "$id" "rework run stopped, see NEEDS-YOU.md" $?
        next=review ;;
      review)
        if [ "$(stage_of "$id")" != review ]; then stop "$id" "not in review/ but in $(stage_of "$id")/"; fi
        pr=$(field "$(ticket_file "$id")" pr)
        [ -n "$pr" ] || stop "$id" "no pr: in the ticket"
        bash "$hq/scripts/review.sh" "$id" "$pr" || stop "$id" "reviewer run stopped, see NEEDS-YOU.md" $?
        # After the round cap the reviewer moves the ticket to blocked/ itself.
        if [ "$(stage_of "$id")" = blocked ]; then stop "$id" "blocked by the reviewer after the round cap"; fi
        v=$(verdict "$(ticket_file "$id")")
        if is_approve "$v"; then next=merge; else next=rework; fi
        commit_board "$id ${v%% - *}" ;;
      merge)
        pr=$(field "$(ticket_file "$id")" pr)
        # merge.sh refuses (and writes NEEDS-YOU.md) for user_check / user_ok gates, red CI and the like.
        bash "$hq/scripts/merge.sh" "$id" "$pr" || stop "$id" "merge refused or failed, see NEEDS-YOU.md" $?
        commit_board "$id done"
        echo "$id: merged, PR #$pr"
        break ;;
    esac
  done
done
echo "DONE: $* merged"
