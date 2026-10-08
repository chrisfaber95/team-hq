---
id: T-007
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-001
depends_on: [T-005, T-006]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The user sees what needs them without watching terminals: a header badge, a "Needs attention" list with dismiss
buttons, a toast for each new alert, and a threshold setting.

## Acceptance
- [ ] Header badge shows the number of open alerts from `DashboardState.alerts`; hidden at zero
- [ ] "Needs attention" list shows each alert's text (window, percentage and reset time for usage alerts) with a dismiss button that calls `POST /api/alerts/dismiss`; the list updates from SSE without duplicates
- [ ] A toast appears for an alert id that was not in the first state received after page load, so reloading never re-toasts existing alerts
- [ ] A threshold input (1-100 %) shows the current `alerts.threshold` and saves through `POST /api/settings/alerts`
- [ ] Pure client logic (new-alert detection, badge count) has `node:test` coverage; `npm run typecheck` and `npm test` pass

## Notes (lead)
Follow "UI conventions" in `docs/architecture.md` (all skins, no inline styles, every value through `esc()`, tooltips
via `textContent`); include that section in the `frontend-developer` delegation. Model the section on
`src/client/team.ts` (rebuild only when changed); put pure logic in its own module like `mood.ts`. Out of scope: OS
notifications, actions from an alert.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
