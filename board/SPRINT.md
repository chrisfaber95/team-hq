# Sprint summary: sprint 12 (2026-10-16, phase 2)

F-008 (Session communication as an isometric kingdom) is built and on `main`. It was the first epic under decision
0008: five tickets merged into `epic/F-008`, then one feature-reviewed PR (#114) into `main`. The user OK'd the
merge up front ("user_check is oke"), so it did not wait for a browser check. The user's local `main` is
fast-forwarded to 8ea754a. Every PR was approved in round 1, and CI was green on every one.

## Shipped

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| T-097 | kingdom model: castle `needsYou`, court + districts, building kinds, castle mailmen | #110 | 1 |
| T-098 | kingdom layout on the iso grid (wide + tall), stable cells, mailman routes on paths | #111 | 1 |
| T-099 | kingdom scene: wall, towers, square, castle banner, building states, workers | #112 | 1 |
| T-100 | kingdom motion: mailmen walk, workers come/go, smoke, banner wave; idle = nothing runs | #113 | 1 |
| T-101 | Session communication popup full screen on desktop | #109 | 1 |
| T-102 | epic F-008 -> `main` (feature review against the brief, full CI) | #114 | 1 |

## Open

| Item | Status | Next step |
| --- | --- | --- |
| T-045 | backlog, owner user | user's approve/deny check from a paired device |

The board has no ready, in-progress, review or blocked tickets. No approved briefs are waiting.

## Waiting on the user

- **F-008 browser look** (NEEDS-YOU 2026-10-16): castle banner, court and districts, building states, workers,
  mailmen on the paths, full screen on desktop, vertical scroll on phone.
- Browser checks: F-007 city (2026-10-15; now replaced by the kingdom, so only the feed and roster still apply),
  the whole Vue client after sprint 10, and the Vite switch (2026-10-11).
- T-045 approve/deny check. Remove `N:\tmp-t044\`.
- Design session: phone/tablet app + voice (decision 0007 "Later").

## Decisions

- No new decision records. The lead answered the brief's open questions in T-102's notes:
  - Building kinds: hall (lead), workshop (engineers), guild (reviewer and designer), house (project sessions).
  - "Needs the user" means an F-001 alert or a pending permission request.
  - The data has no messages *from* the user, so castle mailmen only arrive, sent when a session starts to need
    the user.
- The epic flow from [0008](../decisions/0008-epic-branches.md) worked end to end: `epic.sh open`, then child
  tickets, then `epic.sh pr`, then a feature review, then `merge.sh`.

## Metrics

- Engineers: $4.44 for 5 PRs. Reviewers: $0.91 for 6 reviews, including the epic feature review ($0.15).
  Rows are in `metrics/baseline.md`.
- Engineer runs took 3-21 turns, with no rework.
- Messages: 1 per ticket. T-098 sent none: its run hit the account session limit (429) after it had opened the PR
  and moved the ticket.

## Notes for next sprint

- **A session-limit exit after the PR is not a failure.** `dispatch.sh` blocked T-098 (exit 1), but the ticket
  was already in `review/` with its hand-off. Check the ticket and the `logs/<id>.json` tail before re-running.
- T-100 sets the walk-step delay through a `--step` custom property instead of the 24 `iso-step--N` classes, so
  long walks work. `docs/isometric.md` "Walking" still describes only the classes; update the doc if this is
  kept.
- T-098 puts buildings over capacity (court 20, district 12) into `layout.overflow`, shown as "+N". The tall
  layout has no trees.

## Next sprint

1. Turn the user's F-008 browser-look findings into tickets (fixes go to `main`; the epic is closed).
2. T-045, once the user has run the device check.
3. Check `product/briefs/` for newly approved briefs. Each one gets `epic.sh open` before its first dispatch.
