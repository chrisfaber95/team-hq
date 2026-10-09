---
id: T-013
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-012]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 28
---
## Goal
The owner can read the audit log in the dashboard and filter it by device.

## Acceptance
- [ ] An Activity (audit) section lists entries from `GET /api/audit`: time, device, action, project/session, ok, and the prompt excerpt
- [ ] A device filter (all devices + each device name seen in the entries) reloads the list with `?device=<id>`
- [ ] Loaded on open and refreshable; no polling faster than the SSE tick
- [ ] Pure client logic (filter options, row formatting) has `node:test` coverage; `npm run typecheck` and `npm test` pass

## Notes (lead)
Follow "UI conventions" in `docs/architecture.md`; include it in the `frontend-developer` delegation. Prompt excerpts
are user text: `esc()` everywhere, tooltips via `textContent`. Not `low-risk` because it renders audit data, but no
`auth` label: it only reads an existing endpoint.

## Hand-off (engineer writes, max 300 tokens)
Added the Activity section (`<details id="audit">`, src/client/audit.ts + audit-logic.ts + index.html/style.scss/app.ts): loads GET /api/audit only on open, on a device-filter change and on Refresh (no polling, nothing on SSE pushes), stale responses ignored; rows show time, device, action, project/short session, ok/failed text and the prompt excerpt (data-tip for the full text); the dropdown lists the devices seen and keeps earlier choices; an error clears the old rows. AuditEntry moved to shared types. PR: https://github.com/chrisfaber95/claude-dashboard/pull/28. typecheck ok, npm test 278 pass, build ok.
security-auditor: no XSS/CSP findings. Fixed L1 (unfilterable ids offered) and L4 (stale rows beside an error). Not changed: M1 any signed-in device reads every device's prompts (as specified in T-012; could restrict `prompt` to the PC), L2 no bidi/control stripping on device/project text, L3 prompts stay in the DOM after closing. NOT checked in a browser (3 skins, light/dark). Reviewer: esc() on every interpolation in rowHtml/syncOptions, no polling. frontend-developer wrote the UI; audit-logic.ts directly. PR title is T-013 form.

## Review (reviewer writes, one line per round)
round 1: approve
