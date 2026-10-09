---
id: T-009
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-008]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The PC can create, list and revoke devices through API endpoints that only a loopback request can reach.

## Acceptance
- [ ] `POST /api/devices` with `{ name }` (1-40 printable chars, trimmed) returns `{ id, token }` once; the token is never returned again by any endpoint
- [ ] `GET /api/devices` returns `id`, `name`, `createdMs`, `lastSeenMs` per device (no hashes); `POST /api/devices/revoke` with `{ id }` revokes via the T-008 store; unknown id -> 404 with a fixed string
- [ ] All three answer only the loopback-exempt `pc` (decision 0003); a signed-in non-loopback device gets 403; existing Origin/`X-Dashboard`/cross-site checks and the body cap apply
- [ ] `DashboardState.features` gains `manageDevices: boolean` (true only for the loopback `pc` request) so the UI can hide the section elsewhere
- [ ] Tests for each endpoint incl. the 403 from a non-loopback device and that the token appears only in the create response; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0003-device-tokens.md`. Follow the T-006 endpoints in `src/server/server.ts`. `features` is
built per request, so the flag depends on the caller. Audit device create and revoke via `audit()` (name and id,
never the token). Run `security-auditor` before the PR.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
