---
name: sprint-summary
description: Close a sprint - write board/SPRINT.md from the board and commit team-hq so the lead can /clear and start fresh. Use at the end of a sprint or when the lead's context gets large.
---

# Sprint summary

1. Gather from every repo board `board/<repo>/` (not from memory of the conversation):
   - `done/` tickets merged this sprint (check `gh pr view <pr> --json state,mergedAt`); move any
     merged ticket still in `review/` to `done/`.
   - Open work in `ready/`, `in-progress/`, `review/`, `blocked/`.
   - Unticked items in `NEEDS-YOU.md`.
   - Decisions added to `decisions/` this sprint.
2. Overwrite `board/SPRINT.md` with, under 80 lines (Shipped and Open grouped by repo):
   - **Shipped**: id, title, PR, review rounds.
   - **Open**: id, status, next step.
   - **Waiting on the user**: the unticked NEEDS-YOU items.
   - **Decisions**: links.
   - **Metrics**: per merged ticket, review rounds and (if known) engineer cost from `logs/<id>.log`;
     add rows to `metrics/baseline.md` under "Team runs".
   - **Next sprint**: the 3-5 tickets to dispatch first.
3. Commit everything in `team-hq`: `git add -A && git commit -m "sprint: <date> summary"` and `git push`.
4. Tell the user: "Sprint summary written; run /clear to start the next sprint."
