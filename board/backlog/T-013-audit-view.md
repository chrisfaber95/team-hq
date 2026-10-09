---
id: T-013
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-012]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
