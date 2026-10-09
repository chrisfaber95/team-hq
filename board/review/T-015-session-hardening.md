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
user_ok: true
pr: 29
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
auth.ts: all session endings (logout, expiry on use/sweep, cap, revoke) go through one endSession() that fires onSessionEnd (exceptions contained); sweepExpired() ends expired sessions (and those of a device gone from the store); a session ends 90 days after sign-in (the 7-day slide is capped at startedAt+90d); max 10 sessions per device, oldest ends when an 11th signs in (login and QR pairing); identify() returns sid; revoke listeners guarded. server.ts: /api/events streams tracked with device + session and closed when either ends; the 2 s tick calls sweepExpired() first (an open stream makes no requests); PC loopback stream has no session. PR: https://github.com/chrisfaber95/claude-dashboard/pull/29. typecheck ok, npm test 289 pass; build not run (no client change).
security-auditor: no Critical/High. Fixed L1, L2. Not changed: M1 the cap evicts oldest-by-sign-in, so a stolen token can sign in 10 times to evict the owner's sessions (nuisance; spec says oldest first; LRU eviction and an alert on cap eviction are options; also successful logins reset the per-IP failure counter, pre-existing), L3 cookie Max-Age stays 7 d near the 90 d limit, L4 no listener unregister. Reviewer: check endSession paths, the cap arithmetic in startSession and the tick in server.ts. The expiry test moves a clock 8 days (lan.test.ts) and waits one tick. Not run in a real LAN session. PR title is T-015 form; no auth label.

## Review (reviewer writes, one line per round)
