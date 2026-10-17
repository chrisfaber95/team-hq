---
id: T-020
repo: claude-dashboard
owner: eng-claude-dashboard-T-020
brief: F-002
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: false
pr: 32
---
## Goal
One end-to-end test file walks F-002's success story against a real LAN-mode server, so a regression in device
login, revoke or the audit trail fails CI instead of waiting for a manual phone check.

## Acceptance
- [ ] On a LAN-mode server started in the test (non-loopback `Host`/socket, as `lan.test.ts` does): a request without a device token is refused for a page, an API call and the live event stream; the old shared token is refused too
- [ ] From loopback: create a named device (token shown once), and it appears in the device list; the device signs in once by token and once by QR code, and the same QR code fails a second time
- [ ] The signed-in device can view state, start a command and message and stop a session (`fake-claude.mjs`), and `/api/audit` lists each action under the device's name, with the device filter applied
- [ ] Revoke from loopback: the device's open event stream ends, its next API call is refused and its token no longer signs in; a failed LAN sign-in raises the needs-attention alert with time and source address
- [ ] `npm run typecheck` and `npm test` pass; the new test runs in under ~10 s and leaves no server or temp files behind

## Notes (lead)
Tests only: no product code changes. If a check fails because of a real bug, mark it `todo` with the reason, note
it in the hand-off and the lead writes a follow-up (fixing it would be `auth` work). Reuse `tests/helpers.ts`,
`tests/fake-claude.mjs` and the setup in `lan.test.ts` / `devices.test.ts` / `auth.test.ts`; don't duplicate their
unit cases, this is the flow across them. Design: `decisions/0003-device-tokens.md`. The visual check in three skins
and the real-phone check (cert warning, camera QR scan) stay with the user.

## Hand-off (engineer writes, max 300 tokens)
Added tests/f002-flow.test.ts (tests only, no product code): one sequential test on a real LAN-mode server walks F-002 - unauthenticated page/API/event stream and the old shared token refused; loopback creates a device, token shown once, listed; sign-in by token and QR (QR fails 2nd time); device views state, starts a command, messages and stops a session via fake-claude; /api/audit shows each action under the device name with filter; revoke ends the stream, 401s the next call and the token; failed sign-in alert with address and time. typecheck clean, npm test 324/324, new test ~0.3 s, cleans up. No bugs found. PR: https://github.com/chrisfaber95/claude-dashboard/pull/32 . Reviewer: check the audit assertions and that the stream-end check is not flaky (2 s wait).

## Review (reviewer writes, one line per round)
round 1: approve
