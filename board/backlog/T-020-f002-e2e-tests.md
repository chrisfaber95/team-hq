---
id: T-020
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
