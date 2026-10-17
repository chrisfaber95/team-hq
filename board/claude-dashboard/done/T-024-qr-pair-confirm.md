---
id: T-024
repo: claude-dashboard
owner: eng-claude-dashboard-T-024
brief: F-002
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 38
---
## Goal
Scanning a device's QR code on a real phone signs that phone in. Today it lands on the login page with nothing filled
in (user report, 2026-10-09).

## Acceptance
- [ ] `GET /pair?c=<code>` has no side effect: it serves a small page ("Sign in as <device name>?" + button) and does not spend the code, so a camera/link preview or prefetch can't use it up; unknown or expired code -> the page says so with the existing fixed text
- [ ] The button sends the code with a same-origin `POST /pair` (CSRF-safe the same way as the login form); a good code spends it, sets the session cookie and the page then navigates to `/` itself (not a 303 at the end of a navigation that started in another app), so the `SameSite=Strict` cookie is sent; failures keep the rate limit + `signin:<address>` alert
- [ ] Code stays single-use and expires as now (`PAIR_MS`); the QR still holds only the pairing code, never the token; cookie attributes unchanged
- [ ] Tests: GET twice leaves the code valid; POST signs in once and fails the second time; expired/unknown code; the flow in `tests/f002-flow.test.ts` is updated to GET then POST; `npm run typecheck` and `npm test` pass

## Notes (lead)
Likely causes, both fixed by the confirm step (engineer: confirm which one in the hand-off if you can tell):
1. `/pair` GET spends the code on first use (`auth.ts` `pair()`, `server.ts:204-213`); phone camera apps and link
   previews often fetch the URL before the browser opens it, so the browser's own GET fails -> `/login?e=pair`.
2. The 303 to `/` with `Set-Cookie: ...SameSite=Strict` ends a navigation started from the camera app (cross-site);
   browsers don't send a Strict cookie on that request -> plain `/login`.
User follow-up: the phone lands on the plain login page ("paste the token...", no QR error), so it is cause 2.
T-020's end-to-end test passed because a test client neither prefetches nor applies SameSite. Design:
`team-hq/decisions/0003-device-tokens.md` (QR = single-use pairing code in a URL; unchanged). Keep the page under the
existing CSP (external script, like `login.js`). Don't touch `claude-cli.ts`.

## Hand-off (engineer writes, max 300 tokens)
Changed: `GET /pair?c=` no longer spends the code. It serves `pair.html` ("Sign in as <device>?", name escaped server-side via new `auth.peekPairing()`, or the fixed expired/used text) plus external `pair.js`. The button does a same-origin `POST /pair` (form body `c=`): good code spent, 200 + cookie, then `pair.js` does `location.replace('/')`; bad 401, limited 429; rate limit and signin alert kept. TTL, single use, cookie attributes and QR content unchanged. Docs, build and dev scripts updated.
Cause: both are fixed, and I can't tell which one hit the phone (not tried on a real phone or browser; `pair.ts` is only built, not run).
Checks: typecheck, 344 tests and build pass. security-auditor: no critical, high or medium findings.
PR: https://github.com/chrisfaber95/claude-dashboard/pull/38 (CI was not green yet when it opened).
Reviewer: the POST /pair Origin path, the unrate-limited GET peek (deliberate), and the bad-code page briefly showing "Sign in as" until `pair.js` removes it. The commit trailer says plain "Claude" (memory rule).

## Review (reviewer writes, one line per round)
round 1: approve (all 4 criteria met; Origin check, escaping, single use and rate limit/alert verified in diff and tests; CI `check` was still running at review time, merge.sh must wait for green; flow untested on a real phone)

lead: user confirmed QR sign-in works on a real phone (2026-10-09), after restarting dev:lan.
