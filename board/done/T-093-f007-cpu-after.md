---
id: T-093
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-007
depends_on: [T-091, T-092]
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 1          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr: 106
---
## Goal
Show that the city popup keeps the F-004 CPU gains, measured the F-004 way with the popup open.

## Acceptance
- [ ] `docs/perf.md` gets an "After F-007" table: main after T-091, `--popup comms`, same PC, browser,
      method, runs and viewports as T-092's "Before F-007" (1 run x 60 s per viewport, popup open and closed)
- [ ] Popup-closed medians stay at F-004 levels (0.16 % desktop, 0.10 % phone, within run-to-run noise),
      and popup-open medians with no postman moving are at most 0.1 percentage point above popup-closed;
      if not, the ticket goes to `blocked/` with the numbers instead of a PR
- [ ] `npm run typecheck` and `npm test` pass
- [ ] Changed text follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Docs-only PR (`docs/perf.md`), like T-029. If the numbers miss, the lead writes the fix ticket.
- 2026-10-15 user: CPU measurement is off from now on, and this ticket may stop measuring. The two
  measurement criteria above are optional: record only runs already finished (say which), or none with one
  line "After F-007: not measured (CPU measurement off, user 2026-10-15)". Then open the PR as usual.

## Hand-off (engineer writes, max 300 tokens)
Docs-only PR #106 (https://github.com/chrisfaber95/claude-dashboard/pull/106): "After F-007" section in docs/perf.md, 3 x 60 s runs per row on 0d5b898 (`--popup comms`), plus a pre-T-091 control (cab3b0b, 2 runs). Open vs closed: +0.08 pts desktop, +0.09 pts phone (limit 0.1). Closed desktop 0.16 % (F-004 level). Closed phone 0.15 % vs 0.10 % in F-004: above, but the control gave 0.12-0.15 %, so likely drift, not proven. Runs are shorter (60 s) and few; measurement stopped per user 2026-10-15. Reviewer: judge whether the phone-closed rise is acceptable noise. Typecheck/lint/tests skipped (docs only).

## Review (reviewer writes, one line per round)
round 1: approve
