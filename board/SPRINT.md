# Sprint summary: sprint 5 (2026-10-09, phase 2)

First phase-2 sprint: every engineer and reviewer ran headless per ticket (`dispatch.sh` / `review.sh` / `merge.sh`),
up to 2 engineers in parallel. Finished F-003 (chat recap + model summary), the F-002 end-to-end test, and two bugs
the user found on a real phone.

## Shipped

| Ticket | Title | PR | Review rounds |
| --- | --- | --- | --- |
| T-020 | F-002 end-to-end test (tests only) | #32 (6b8a519) | 1 |
| T-018 | Session recap for chat `summary` (+ T-017 endpoint-test hardening) | #33 (6422eea) | 1 |
| T-019 | Model summary setting (`auth`, `user_ok`) | #34 (cdc7c1b) | 1 |
| T-021 | Model summary cache + cooldown; honest setting when commands are off | #35 (a005b0f) | 1 |
| T-022 | Summary cache: one in-flight call, no stale answer after a failure | #36 (26eaf9d) | 1 |
| T-023 | LAN startup prints the localhost URL for this PC (`auth`, user report) | #37 (3d7b7cc) | 1 |
| T-024 | QR pairing confirm page + POST (`auth`, user report; verified on a phone) | #38 (20fcd90) | 1 |

## Open

Board is empty (no backlog, ready, in-progress, review or blocked tickets).

## Waiting on the user

Nothing unticked in `NEEDS-YOU.md`. Open questions from the lead:
- **Persist LAN sessions** in `DATA_DIR` so a server restart (every merge touching `src/server` restarts `dev:lan`)
  doesn't sign phones out? Changes decision 0003, `auth`. Lead recommends yes.
- **This PC by its LAN IP** without login? Currently by design not exempt (decision 0003); T-023 only prints localhost.
- Browser checks: chat recap/model summary and the "Commands are off" note, three skins, 375 px.
- Remove the empty folder `N:\worktrees\claude-dashboard-T-019` (lead's `rmdir` was denied).

## Decisions

- No new decisions. [0003](../decisions/0003-device-tokens.md) and [0004](../decisions/0004-chat-without-a-model.md)
  still apply; 0003 gets an amendment if the user approves persisted sessions.

## Metrics

Engineer runs are headless now, so cost is logged. Messages: 1 per ticket (engineer -> lead), target 3.

| Ticket | PR size | Rounds | Engineer | Review | Merge |
| --- | --- | --- | --- | --- | --- |
| T-020 | +164/-0 | 1 | $0.54 | $0.14 (+$0.08 failed run) | $0.16 |
| T-018 | +291/-10 | 1 | $1.45 (2 runs) | $0.16 | $0.13 |
| T-019 | +338/-14 | 1 | $1.88 | $0.22 | $0.15 |
| T-021 | +121/-4 | 1 | $0.52 | $0.16 | $0.14 |
| T-022 | +69/-13 | 1 | $0.39 | $0.15 | $0.12 |
| T-023 | +32/-3 | 1 | $0.31 | $0.13 | $0.13 |
| T-024 | +178/-40 | 1 | $1.03 | $0.18 | $0.15 |

Total ~$9.2 for 7 tickets. Rows added to `metrics/baseline.md` "Team runs".

## Notes for next sprint

- **Account session limit** stopped T-018's engineer and T-020's reviewer mid-run (12:05, reset 14:00). The scripts
  escalated correctly; `--rework` resumed T-018 from its uncommitted worktree. A limit-hit run should not count as
  "blocked twice".
- **Hung engineer:** T-019's `claude -p` finished at 14:14 but its process lived until 14:32 (Playwright MCP from the
  repo's MCP config as child; killing that didn't help). Its worktree folder could not be removed. If it repeats,
  keep the Playwright MCP out of headless engineer runs (`engineer.settings.json`; needs the user's OK).
- `num_turns` in the JSON is often 1-6 while the work clearly took more (subagents not counted); use cost, not turns.
- `merge.sh` updates `N:\Projects\Claude-dashboard`, where the user runs `dev:lan`: server merges restart it and drop
  in-memory sessions; a change to `scripts/dev.mjs` needs a full `dev:lan` restart (T-024's new page wasn't built).
- T-020's end-to-end test passed while QR sign-in was broken on a real phone (prefetch/SameSite are browser-only).
  Real-phone checks stay with the user.
- Reviewers often approve with CI still pending; `merge.sh` checks CI itself, the lead waited for green before merging.

## Next sprint

1. Persist LAN sessions across restarts (`auth`, needs the user's yes + decision 0003 amendment).
2. IPv6 /64 bucketing for rate limit and sign-in alerts (T-014 M1/M2).
3. LRU session eviction with an alert (T-015 M1).
4. `merge.sh` warns (NEEDS-YOU or output) when a merge changes `scripts/dev.mjs` or `src/server` while `dev:lan`
   runs. The checkout now ends on an updated `main` (20fcd90), so the old detached-HEAD note is resolved.
