---
id: T-014
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-002
depends_on: [T-008]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
A failed LAN sign-in shows up as a needs-attention alert with its time and source address, so the owner notices
someone trying tokens.

## Acceptance
- [ ] Each failed or rate-limited LAN sign-in adds to one alert per source address (id `signin:<address>`, kind `signin`): detail shows the address, the last failure time and the number of failures; repeat failures update the alert instead of adding new ones
- [ ] The alert stays until dismissed; a new failure from that address after dismissal opens it again
- [ ] Failure records are in memory only, at most 50 addresses (oldest dropped), never containing the attempted token
- [ ] Shown through the existing F-001 badge, list and toast without client changes beyond the new `kind` (if any)
- [ ] Tests for update-not-duplicate, dismiss then re-open, the cap and that no token text is kept; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0002-alerts-derived-on-server.md` and `0003-device-tokens.md`. Hook into T-008's
failed-sign-in callback; derive the alert in `src/server/alerts.ts` like the other kinds. Address = socket
`remoteAddress` (never a forwarded header). T-011 will report bad pairing codes through the same hook. Run
`security-auditor` before the PR.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
