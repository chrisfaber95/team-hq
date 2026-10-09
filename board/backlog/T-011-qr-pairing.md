---
id: T-011
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-010]
contracts: []
labels: [auth, deps]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
A phone signs in by scanning a QR code shown on the PC; each QR works only once.

## Acceptance
- [ ] Loopback-only `POST /api/devices/pair` with `{ id }` returns a single-use pairing URL (`/pair?c=<random code>`) for that device, valid 10 minutes; codes are kept in memory only
- [ ] Opening the URL signs the browser in as that device (session cookie as in T-008) and redirects to `/`; a used, expired or unknown code -> the login page with an error, and the attempt counts toward the existing login rate limit
- [ ] Revoking a device invalidates its unused pairing codes
- [ ] The Devices section has a "Show QR" button per device that renders the URL as a QR (SVG, no inline styles) using `qrcode-generator`, bundled by esbuild; the QR never contains the device token
- [ ] Tests for code issue, single use, expiry, revoke; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0003-device-tokens.md`. New dependency `qrcode-generator` approved in principle by the user;
add it as a devDependency (bundled, nothing new at server runtime) and note the version in the hand-off. `/pair` must
be added to the paths reachable without a session (`PUBLIC_PATHS` in `server.ts`) with care: GET only, no other
side effects. Check the CSP still holds (no inline scripts or styles). Run `security-auditor` before the PR.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
