# Sprint summary: sprint 4 (2026-10-09, phase 1)

F-003 Ask-the-dashboard chat, first half: the intent module and the chat panel. Run interactively: lead (opus),
`eng-claude-dashboard` (sonnet) in the main checkout, `reviewer`. The user paused the sprint after T-017.

## Shipped

| Ticket | Title | PR | Review rounds |
| --- | --- | --- | --- |
| T-016 | Chat intents (`chat-logic.ts`, pure) | #30 (b558edc) | 2 (round 1: ack/open/summary verbs swallowed "view usage", "go to alerts" etc.; unguarded `usage.totals`) |
| T-017 | Chat panel with Confirm step | #31 (1d9bdf6) | 1 |

## Open

| Ticket | Status | Next step |
| --- | --- | --- |
| T-018 | backlog (deps done) | Session recap for `summary`; move to `ready/` and dispatch |
| T-019 | backlog, `auth`, `user_ok: true` | Model summary setting; after T-018 |
| T-020 | backlog, `low-risk` | F-002 end-to-end test (LAN server: token, QR, actions, audit, revoke, alert); no product code |

## Waiting on the user

Nothing unticked in `NEEDS-YOU.md` (user set `user_ok` on T-019 this sprint). Checks only the user can do:
- Chat panel in a browser: 375 px and desktop, all three skins, Confirm/Cancel on a real session, `open` drawer.
- Still open from sprint 3: F-002 end to end on a phone (token, QR, revoke lock-out, Activity names the phone) and
  the visual check of Devices/QR/Activity/alerts/Team in three skins; does `status` become `waiting` on a permission prompt?

## Decisions

- [0004](../decisions/0004-chat-without-a-model.md): chat answers from dashboard state with fixed intents, no model;
  messages need Confirm; the chat never starts/stops sessions; an optional cheap-model summary only in T-019.

## Metrics

Engineer cost unknown (interactive, no `dispatch.sh` JSON). Merge runs from `logs/<id>.merge.json`.

| Ticket | PR size | Rounds | Messages (target 3) | Merge run |
| --- | --- | --- | --- | --- |
| T-016 | +420/-1 | 2 | 6 | $0.14, 5 turns |
| T-017 | +396/-1 | 1 | 3 | $0.14, 7 turns |

## Notes for next sprint

- The engineer and reviewer sessions were not `/clear`ed between tickets (both ~12h old); clear them before T-018.
- T-017 hardening candidate (reviewer, non-blocking): the forbidden-endpoint test scans `chat.ts` only for `/api/`
  literals; a path built without one would pass. Fold into T-018 or a small follow-up.
- Pointing the reviewer at the engineer's own "check this" list worked: T-016 round 1 found exactly that issue.
- `merge.sh` still leaves the repo checkout on a detached HEAD; engineers branch from `origin/main` explicitly.

## Next sprint

1. T-018 session recap (F-003), then T-019 model summary (`user_ok` set).
2. T-020 F-002 end-to-end tests; no overlap with chat, can run beside T-018 once phase 2 parallelism is used.
3. Smaller candidates: IPv6 /64 bucketing for rate limit and sign-in alerts (T-014 M1/M2); LRU session eviction with
   an alert (T-015 M1); `merge.sh` ends on an updated `main`; harden T-017's endpoint test.
