---
id: T-008
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true
pr: 22
---
## Goal
LAN sign-in uses named, revocable per-device tokens instead of the one shared token, and the PC on loopback needs no
token, so a lost device can be cut off without touching the others.

## Acceptance
- [ ] Device store in `DATA_DIR/devices.json` (`id`, `name`, token `sha256`, `createdMs`, `lastSeenMs`; never the token), with `create(name) -> { id, token }`, `list()`, `revoke(id)`; corrupt or missing file -> empty store, no crash; `lastSeenMs` updated on authed requests, written at most once a minute per device
- [ ] LAN login accepts a device token (timing-safe hash compare, existing rate limit kept) and binds the session to the device id; the old `DATA_DIR/token` is no longer read and is removed at startup
- [ ] In LAN mode, a request with loopback `remoteAddress` and a loopback `Host` needs no token and acts as device `pc`; any other request without a valid session gets 401 (API) / redirect (page) / no live-event stream, as today
- [ ] `revoke(id)` ends that device's sessions and closes its open `/api/events` streams at once
- [ ] Device tokens have no expiry; a device session slides: each authed request extends it to 7 days from now (cookie re-issued at most once a day), so only revocation (or 7 days unused) signs a device out
- [ ] `node:test` coverage for the store, login, revocation (session and live stream), loopback exemption incl. a non-loopback `Host` on a loopback socket being refused; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0003-device-tokens.md`. Code: `src/server/auth.ts` (`createAuth`, `loadOrCreateToken`),
`src/server/server.ts` (login, `isAuthed` gate, SSE `clients`, startup). No endpoints or UI in this ticket (T-009,
T-010); the store API is enough, and LAN devices can't sign in until T-009/T-010 merge, which is fine.
Never trust `X-Forwarded-For` or similar headers. Keep every rule in the repo CLAUDE.md "Network" and "Request checks"
lists. Isolate `DASHBOARD_DATA_DIR` and `TEAM_HQ_DIR` in tests (see T-006 round 1). Run `security-auditor` before the
PR and put its result in the hand-off. Update `docs/architecture.md` (`auth.ts`, `.dashboard/` contents).
Expose a failed-sign-in hook (e.g. an `onFailedLogin(ip, tMs)` option of `createAuth`) for T-014; no alert in this ticket.

## Hand-off (engineer writes, max 300 tokens)
Added src/server/devices.ts (store in DATA_DIR/devices.json: sha256 only, timing-safe verify, revoke, lastSeen written at most once a minute) and rewrote auth.ts: device-token sign-in (rate limit kept, onFailedLogin hook), device-bound sliding 7-day sessions, identify() with the loopback exemption (loopback socket AND loopback Host => `pc`; proxy headers withdraw it), revokeDevice() ends sessions and server.ts closes that device's /api/events streams; old DATA_DIR/token deleted at startup. PR: https://github.com/chrisfaber95/claude-dashboard/pull/22. typecheck ok, npm test 218 pass.
security-auditor: no Critical/High. Fixed M1 (partly: proxy headers, documented), L2 (device in audit log), L7 (names). Not done: L1, L3 (failed save can undo a revoke on restart), L4 (logout/expiry keep an open stream), L5, L6. Reviewer: check the exemption in auth.ts isLoopbackRequest, that no endpoint exists yet (T-009/T-010), the startup token removal in server.ts (untested), and that user_ok is needed before merge. Not run in a real LAN session. CLAUDE.md: only the .dashboard/ secrets line changed. PR title is T-008 form.

## Review (reviewer writes, one line per round)
