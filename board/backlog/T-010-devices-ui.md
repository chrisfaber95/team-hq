---
id: T-010
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-009]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
On the PC, a Devices section lets the owner add a named device (token shown once), see every device with created and
last-seen times, and revoke one.

## Acceptance
- [ ] Devices section shown only when `features.manageDevices` is true; hidden on other devices
- [ ] Add form (name) calls `POST /api/devices` and shows the token once with a copy button; it disappears when dismissed or on reload and is never stored in `localStorage`
- [ ] List shows name, created date and last-seen time per device, each with a revoke button (with a confirm) calling `POST /api/devices/revoke`; the list updates after create and revoke
- [ ] Pure client logic (formatting, state) has `node:test` coverage; `npm run typecheck` and `npm test` pass

## Notes (lead)
Follow "UI conventions" in `docs/architecture.md` (all skins, no inline styles, `esc()` everywhere, tooltips via
`textContent`) and include it in the `frontend-developer` delegation. Model on `src/client/alerts.ts`. The token is a
secret: render it with `textContent`, keep it out of the DOM after dismissal and out of logs. QR comes in T-011.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
