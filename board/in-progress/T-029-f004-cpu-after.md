---
id: T-029
repo: claude-dashboard
owner: eng-claude-dashboard-T-029
brief: F-004
depends_on: [T-025, T-028]
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 0
user_ok: false
pr:
---
## Goal
Show that the F-004 dashboard uses less CPU than before, and close the brief's remaining checks.

## Acceptance
- [ ] `docs/perf.md` records the "after" numbers on main after T-028, with the same method, runs and viewports as the
      T-025 baseline; the median is lower than the baseline at both viewports (if not: profile, record the top cost,
      move the ticket to `blocked/`)
- [ ] `docs/architecture.md` describes the in-place update and popup structure in a few lines
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
Brief F-004 acceptance "CPU use ... measured before and after, and is lower after". The browser checks (three skins,
phone/tablet/desktop, no flicker, drawer/selection survive) go to the user via `NEEDS-YOU.md` when this merges.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
