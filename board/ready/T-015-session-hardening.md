---
id: T-015
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
Signing out or a session ending also cuts that browser's live stream, and device sessions can't pile up or live
forever, closing the security-auditor findings L4 and L5 from T-008 (PR #22).

## Acceptance
- [ ] Logout, and a session reaching its expiry, close the `/api/events` streams opened with that session (today only device revoke does)
- [ ] Each device has at most 10 sessions (oldest ended first) and a session ends 90 days after sign-in even while in use (sliding 7 days stays)
- [ ] Tests for stream close on logout and on expiry, the per-device cap and the absolute lifetime; `npm run typecheck` and `npm test` pass

## Notes (lead)
Follow-up from T-008's audit; L1 (same-site GETs on loopback, same as localhost mode) and L6 (rate limit per IP) are
accepted for a LAN. Streams are already tracked per device in `server.ts`; track them per session too. 90 days and
10 sessions are lead defaults, not from the brief. Run `security-auditor` before the PR.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
