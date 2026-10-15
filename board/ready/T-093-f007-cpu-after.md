---
id: T-093
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-007
depends_on: [T-091, T-092]
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:                       # engineer fills in, e.g. 88
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

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
