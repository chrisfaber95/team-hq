---
id: T-023
repo: claude-dashboard
owner: eng-claude-dashboard-T-023
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
Starting in LAN mode tells the user which address to open on this PC (no login) and which ones are for other
devices (token), instead of listing only the LAN addresses, which all show the login page on this PC too.

## Acceptance
- [ ] In LAN mode the startup output first prints the loopback URL (`<proto>://localhost:<port>`) marked as "this PC, no login", then the LAN URLs marked as "other devices, sign in with a device token"; localhost mode output is unchanged
- [ ] The same split applies wherever the app lists its LAN URLs (e.g. the pairing/QR view around `server.ts:391`), if it shows them to this PC
- [ ] No change to `isLoopbackRequest()` or any sign-in rule; a test asserts the startup lines for LAN mode
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
User report 2026-10-09: `npm run dev:lan` prints 3 IP addresses and all go to the login page from the desktop. That
matches decision `team-hq/decisions/0003-device-tokens.md` (last line: a PC browser on its LAN address is not exempt);
the gap is the startup output in `src/server/server.ts:493-499`, which never mentions localhost. Labelled `auth`
because LAN mode counts as auth in this team; the change is output text only.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
