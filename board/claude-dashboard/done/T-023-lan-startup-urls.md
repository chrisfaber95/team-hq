---
id: T-023
repo: claude-dashboard
owner: eng-claude-dashboard-T-023
brief: F-002
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 37
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
PR #37: https://github.com/chrisfaber95/claude-dashboard/pull/37 (commit 082a155, not merged).
Added exported `startupLines()` in `src/server/server.ts`; the listen callback prints it. LAN mode now prints
`https://localhost:<port>` as "this PC (no login)" first, then each LAN URL as "other devices (sign in with a device
token)". Localhost output unchanged. `isLoopbackRequest()` and sign-in rules untouched. Pairing endpoint
(`/api/devices/pair`) returns URLs for the phone being paired, so it was left as is. New `tests/startup-lines.test.ts`
(3 tests). Local: typecheck clean, 345 tests pass. CI status not checked; not run by hand in LAN mode.
Reviewer: check the line wording, and that the pairing URLs need no split. PR title lacks a conventional `type(scope):` prefix.

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met; output-text only, auth untouched; typecheck + 345 tests pass locally (CI `check` still in progress at review time, merge.sh must see it green); pairing URLs are for the phone so no split needed; labelled `auth`, so needs user_ok before merge.
