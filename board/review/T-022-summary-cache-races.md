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
pr: 36
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
PR #36: https://github.com/chrisfaber95/claude-dashboard/pull/36 (only `session-summary.ts` and `tests/summary-model.test.ts`; `claude-cli.ts` untouched).
- Concurrent model-mode requests for one session share an in-flight promise, so only one process starts.
- After a failed call, the previous answer keeps the size/mtime it was made from (only the cooldown clock restarts), so the next request after the cooldown makes a fresh call.
- Two new fake-CLI tests cover both. `npm run typecheck` passes; `npm test` 342/0.
Reviewer: within the cooldown after a failure the older cached answer is still served (existing behaviour, kept). A waiter on a failed call shares the first caller's recap. CI had not started when the PR opened.

## Review (reviewer writes, one line per round)
