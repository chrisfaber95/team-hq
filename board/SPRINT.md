# Sprint summary: sprint 2 (2026-10-09, phase 1)

First brief from the designer, F-001 Needs-attention alerts, split into three tickets and shipped in full. Run
interactively: lead (opus), `eng-claude-dashboard` (sonnet) in the main checkout, `reviewer`.

## Shipped

| Ticket | Title | PR | Review rounds |
| --- | --- | --- | --- |
| T-005 | Alerts derived on the server (`DashboardState.alerts`, `DATA_DIR/alerts.json`) | claude-dashboard #19 (7b45491) | 1 (approved) |
| T-006 | Dismiss and threshold endpoints | claude-dashboard #20 (f312270) | 2 (changes, then approved) |
| T-007 | Alerts UI: header badge, Needs attention panel, toasts, threshold form | claude-dashboard #21 (968c43f) | 1 (approved) |

F-001 is fully shipped (brief `status: handed-off`; the designer moves it to Shipped in `ROADMAP.md`).

## Open

None. `backlog/`, `ready/`, `in-progress/`, `review/` and `blocked/` are empty.

## Waiting on the user

Nothing unticked in `NEEDS-YOU.md`. Two checks only the user can do:
- Look at the alerts badge, panel and toasts (T-007) and the Team section (T-004) in a browser, in all three skins.
  Neither has been checked visually.
- F-001 open question: does a session's `status` become `waiting` on a permission prompt? Not checked (T-005 noted it in
  the dashboard's `docs/architecture.md`). Session alerts depend on it.

## Decisions

- [0002](../decisions/0002-alerts-derived-on-server.md): alerts are derived on the server with one id per condition;
  dismissals and threshold (default 80%) stored in `DATA_DIR/alerts.json` and shared across devices.

## Metrics

Details in `metrics/baseline.md` ("Team runs"). Engineer cost is unknown: the engineer ran interactively, with no
`dispatch.sh` result JSON.

| Ticket | PR size | Review rounds | Merge run | Messages (target 3) |
| --- | --- | --- | --- | --- |
| T-005 | +309/-3 | 1 | $0.13, 6 turns | 3 |
| T-006 | +85/-1 | 2 | $0.13, 6 turns | 6 |
| T-007 | +254/-12 | 1 | $0.16, 7 turns | 3 |

Decision 0001 worked: one-round tickets hit exactly 3 messages. A rework round adds 3 (lead->eng, eng->lead, lead->reviewer).

## Notes for next sprint

- T-006 round 1: tests read the real `N:\team-hq` board through the `TEAM_HQ_DIR` default; CI passed only because the
  folder doesn't exist there. When a ticket touches config with a real-path default, say "isolate it in tests" in Notes.
- The `reviewer` session was never restarted; the "send no message" line in each review request covered decision 0001.
  Restart it anyway before the next sprint.
- The dashboard checkout was left on a stale branch or detached HEAD after merges; each dispatch said "branch from
  updated origin/main". Worth adding to `merge.sh` (check out `main` after merging) or to the engineer skill.
- Engineer cost isn't logged for interactive runs; price from transcripts if the phase-1 gate needs it.

## Next sprint

F-002 Per-device LAN access arrived after this summary and is already split ([decision 0003](../decisions/0003-device-tokens.md)):
T-008 (`ready/`) -> T-009 -> T-010 -> T-011, and T-012 (after T-009) -> T-013. All but T-013 need the user's `user_ok`
(NEEDS-YOU). Dispatch one at a time, starting with T-008. Smaller candidates for later:
1. Hide the Needs attention panel when empty (only if the user wants it after the visual check).
2. Verify `waiting` on permission prompts against a real session and record it (small, docs-only if it holds).
3. `merge.sh`: leave the repo checkout on an updated `main` after merging.
