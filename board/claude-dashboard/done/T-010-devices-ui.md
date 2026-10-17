---
id: T-010
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-009]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 24
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
Added the Devices section (src/client/devices.ts, devices-logic.ts, index.html, style.scss, app.ts): shown only when features.manageDevices is true; add form -> POST /api/devices, token shown once via textContent with Copy/Dismiss, cleared on dismiss/next add/hide and never stored; list from GET /api/devices (on show, after create/revoke, at most every 30 s) with Added/Last seen and a confirmed Revoke. DeviceInfo moved to shared types. PR: https://github.com/chrisfaber95/claude-dashboard/pull/24. typecheck ok, npm test 235 pass, build ok.
security-auditor on the client: no Critical/High; fixed M1 (token box ignored `hidden`), M2 (late create response could write the token into a hidden panel), L3 (stale refresh). Not done: L1 token stays on the clipboard after Copy, L2 no timeout clearing, L4 duplicated 'at most 100 devices' string. NOT checked in a browser: no visual check in the 3 skins, no real copy/revoke click-through. Reviewer: look at token handling in devices.ts and the [hidden] rule. frontend-developer wrote the UI; devices-logic.ts directly. PR title is T-010 form.

## Review (reviewer writes, one line per round)
round 1: approve
