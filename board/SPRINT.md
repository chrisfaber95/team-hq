# Sprint summary: sprint 1 (2026-10-08, phase 1)

First team ticket, run interactively: lead (opus), `eng-claude-dashboard` (sonnet) in the main checkout, `reviewer`.

## Shipped

| Ticket | Title | PR | Review rounds |
| --- | --- | --- | --- |
| T-004 | Team board panel in the dashboard (read-only, `TEAM_HQ_DIR`) | claude-dashboard #18 (c5bedb6) | 1 (approved) |

## Open

None. `backlog/`, `ready/`, `in-progress/`, `review/` and `blocked/` are empty.

## Waiting on the user

Nothing unticked in `NEEDS-YOU.md`.

## Decisions

None added to `decisions/` this sprint. Change made by the setup session: the engineer skill no longer delegates to
code-reviewer or documentation-engineer (b992eec).

## Metrics

Details in `metrics/baseline.md` ("Team runs" and "Same-method comparison", already recorded for T-004).

| Ticket | Engineer cost | Review | Lead | Total | Messages |
| --- | --- | --- | --- | --- | --- |
| T-004 | $1.26 | 1 round, $0.16 (+ merge $0.10) | $0.46 | $1.98 | 4 (target 3) |

Baseline: $1.73-2.02 per PR (same pricing method) on PRs 2.4-4x smaller. Phase-1 gate: 1 of 10 tickets merged.

## Notes for next sprint

- The Team section of T-004 has not been checked in a browser (layout and skins); look at it when the dashboard is next open.
- The message target of 3 per ticket can't be met: every phase-1 ticket uses 4 routed messages.
  Either raise the target to 4 or replace the reviewer's verdict message with an idle notice (user decision).
- CI was still running when the reviewer approved; the lead waited for green before `merge.sh`.

## Next sprint

The backlog is empty. Write 3-5 tickets for `claude-dashboard` with `write-ticket` from the user's next goals and
dispatch them one at a time (phase 1 is interactive, so no `dispatch.sh`).
