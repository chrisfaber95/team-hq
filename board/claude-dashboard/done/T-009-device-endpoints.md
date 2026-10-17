---
id: T-009
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-008]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 23
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
built per request, so the flag depends on the caller. Revoke returns `{ found, persisted }` (T-008 round 1): answer an
error when `persisted` is false. `create()` doesn't report a failed save yet; make it, and answer an error instead of a
token that won't survive a restart. Audit device create and revoke via `audit()` (name and id,
never the token). Run `security-auditor` before the PR.

## Hand-off (engineer writes, max 300 tokens)
Added GET /api/devices, POST /api/devices {name} (token returned once) and POST /api/devices/revoke {id} in server.ts; only the loopback-exempt `pc` may call them (signed-in device 403, no login 401, no-login mode 404), after all existing checks, body cap kept. features.manageDevices is true only for pc, in /api/state and per SSE client. create() now throws and keeps nothing when the save fails (500 'could not save the device'); revoke with persisted=false answers 500. Create/revoke audited (device, id, name, never the token). PR: https://github.com/chrisfaber95/claude-dashboard/pull/23. typecheck ok, npm test 231 pass; build not run.
security-auditor: no Critical/High. Fixed L-2 (tmp file), L-3 (stored id 'pc' ignored); documented M-1 (any local process on the PC can mint a device, per decision 0003). Not done: L-1 commands.log rotation, L-4 two JSON payloads per tick, L-5 streams outlive logout. Reviewer: check the order of checks before the /api/devices block, token appears only in the create response (tests assert this), and the 403 path. The PR has no `auth` label (repo has none). PR title is T-009 form.

## Review (reviewer writes, one line per round)
round 1: approve
