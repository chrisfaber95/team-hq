---
id: T-022
repo: claude-dashboard
owner: eng-claude-dashboard-T-022
brief: F-003
depends_on: [T-021]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The model-summary cache never serves an old answer as current, and two requests at once start at most one model call.

## Acceptance
- [ ] Two concurrent model-mode summary requests for the same session start one model call; the second waits for it (or gets the recap with the cooldown note), never a second process
- [ ] After a failed model call on a changed transcript, the old answer is not stored under the new size/mtime; the next request after the cooldown makes a fresh call
- [ ] Tests with the fake CLI for both cases; `npm run typecheck` and `npm test` pass

## Notes (lead)
Non-blocking points from T-021's review (PR #35). Both are in `src/server/session-summary.ts` (e.g. an in-flight
promise per session; key the cache entry by the size/mtime the answer was made from). Don't change `claude-cli.ts`;
if you must, move the ticket to `blocked/` with why.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
