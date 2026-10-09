---
id: T-011
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-010, T-014]
contracts: []
labels: [auth, deps]
budget_usd: 3
review_rounds: 0
user_ok: true
pr: 26
---
## Goal
A phone signs in by scanning a QR code shown on the PC; each QR works only once.

## Acceptance
- [ ] Loopback-only `POST /api/devices/pair` with `{ id }` returns a single-use pairing URL (`/pair?c=<random code>`) for that device, valid 10 minutes; codes are kept in memory only
- [ ] Opening the URL signs the browser in as that device (session cookie as in T-008) and redirects to `/`; a used, expired or unknown code -> the login page with an error, counts toward the existing login rate limit and raises the T-014 failed-sign-in alert
- [ ] Revoking a device invalidates its unused pairing codes
- [ ] The Devices section has a "Show QR" button per device that renders the URL as a QR (SVG, no inline styles) using `qrcode-generator`, bundled by esbuild; the QR never contains the device token
- [ ] Tests for code issue, single use, expiry, revoke; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0003-device-tokens.md`. New dependency `qrcode-generator` approved in principle by the user;
add it as a devDependency (bundled, nothing new at server runtime) and note the version in the hand-off. `/pair` must
be added to the paths reachable without a session (`PUBLIC_PATHS` in `server.ts`) with care: GET only, no other
side effects. Check the CSP still holds (no inline scripts or styles). Run `security-auditor` before the PR.

## Hand-off (engineer writes, max 300 tokens)
POST /api/devices/pair {id} (PC only) returns {path:'/pair?c=<code>', urls, expiresMs}; code = 32 random bytes, 10 min, in memory, single use (spent even if expired), newest per device only, dropped on revoke. GET /pair?c= (PUBLIC_PATHS, LAN mode, GET only): good code -> 303 '/' + device cookie; else 303 /login?e=pair via the shared 5/min rate limit and onFailedLogin (raises the T-014 alert). Link host from lanAddresses()+localPort, never Host. 'Show QR' per device (qr.ts + devices.ts): SVG via createElementNS, link only in a module variable, cleared on close/expiry/revoke/hide. New devDependency qrcode-generator 2.0.4 (MIT, no deps, no install scripts, installed --ignore-scripts; npm audit 0 vulnerabilities; lock integrity matches the registry). PR: https://github.com/chrisfaber95/claude-dashboard/pull/26. typecheck ok, npm test 261 pass, build ok.
security-auditor: no Critical/High/Medium. Low, unchanged: L1 GET /pair has a side effect (a link-preview bot could spend a code; QR scans fine), L2 login-CSRF theoretical, L3 spent code in history, L4 PAIR_MAX dead code. Reviewer: auth.ts pair()/createPairing(), the /pair handler before the identify gate, the PUBLIC_PATHS change. NOT tried with a phone or browser (QR rendering/scanning, 3 skins); phone shows the self-signed cert warning. .claude/project-params.md dependency policy still lists dev tools only: qrcode-generator is not added there. PR title is T-011 form; no auth/deps labels in the repo.

## Review (reviewer writes, one line per round)
