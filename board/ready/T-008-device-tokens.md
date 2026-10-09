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
user_ok: false
pr:
---
## Goal
LAN sign-in uses named, revocable per-device tokens instead of the one shared token, and the PC on loopback needs no
token, so a lost device can be cut off without touching the others.

## Acceptance
- [ ] Device store in `DATA_DIR/devices.json` (`id`, `name`, token `sha256`, `createdMs`, `lastSeenMs`; never the token), with `create(name) -> { id, token }`, `list()`, `revoke(id)`; corrupt or missing file -> empty store, no crash; `lastSeenMs` updated on authed requests, written at most once a minute per device
- [ ] LAN login accepts a device token (timing-safe hash compare, existing rate limit kept) and binds the session to the device id; the old `DATA_DIR/token` is no longer read and is removed at startup
- [ ] In LAN mode, a request with loopback `remoteAddress` and a loopback `Host` needs no token and acts as device `pc`; any other request without a valid session gets 401 (API) / redirect (page) / no live-event stream, as today
- [ ] `revoke(id)` ends that device's sessions and closes its open `/api/events` streams at once
- [ ] `node:test` coverage for the store, login, revocation (session and live stream), loopback exemption incl. a non-loopback `Host` on a loopback socket being refused; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0003-device-tokens.md`. Code: `src/server/auth.ts` (`createAuth`, `loadOrCreateToken`),
`src/server/server.ts` (login, `isAuthed` gate, SSE `clients`, startup). No endpoints or UI in this ticket (T-009,
T-010); the store API is enough, and LAN devices can't sign in until T-009/T-010 merge, which is fine.
Never trust `X-Forwarded-For` or similar headers. Keep every rule in the repo CLAUDE.md "Network" and "Request checks"
lists. Isolate `DASHBOARD_DATA_DIR` and `TEAM_HQ_DIR` in tests (see T-006 round 1). Run `security-auditor` before the
PR and put its result in the hand-off. Update `docs/architecture.md` (`auth.ts`, `.dashboard/` contents).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
