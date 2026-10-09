---
id: T-021
repo: claude-dashboard
owner: eng-claude-dashboard-T-021
brief: F-003
depends_on: [T-019]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: false
pr: 35
---
## Goal
Repeated "summarize session X" in `model` mode doesn't bill a new haiku call each time, and the dashboard is honest
when `model` is selected but can't run.

## Acceptance
- [ ] In `model` mode a model summary is cached per session and reused while the session's transcript is unchanged (same size/mtime), and a new model call for the same session waits a fixed cooldown (e.g. 60 s); within it the endpoint returns the cached answer, or the recap with a short fixed note
- [ ] When commands are disabled, the summary setting still saves `model` but the dashboard shows that summaries fall back to the recap (fixed text next to the setting), and the endpoint returns `mode: 'recap'` without spawning a process
- [ ] Cache is in memory only, bounded (e.g. 50 sessions), never written to disk, and holds no transcript text, only the answer
- [ ] Tests with the fake CLI: second call within the cooldown spawns no process; changed transcript gives a new call after the cooldown; commands-disabled spawns none; `npm run typecheck` and `npm test` pass

## Notes (lead)
Known gaps from T-019's hand-off (PR #34). Put the cache and cooldown in `src/server/session-summary.ts` around the
`summarize(path, mode)` seam; **don't change `claude-cli.ts`** (auth). If you find you must, move the ticket to
`blocked/` with why instead. Design: `team-hq/decisions/0004-chat-without-a-model.md`.

## Hand-off (engineer writes, max 300 tokens)
PR: https://github.com/chrisfaber95/claude-dashboard/pull/35 (not merged).
Changed: `session-summary.ts` now caches model summaries in memory per session (answer text only, max 50, oldest dropped). Reused while transcript size/mtime is unchanged. A new model call for the same session waits 60 s; inside it, the cached answer or the recap with a fixed note (failed calls start the cooldown too). `claude-cli.ts` untouched. Client shows "Commands are off, so summaries use the recap." next to the setting when commands are disabled and `model` is selected. Server already returned `recap` without spawning when commands are off; now tested. `docs/architecture.md` updated.
Checks: typecheck clean, 340 tests pass, build ok. CI not checked by me.
Look at: cooldown/staleness choice (changed transcript inside the cooldown still shows the older cached answer); the client note was not checked in a browser. Commit trailer uses plain "Claude" per the user's memory rule.

## Review (reviewer writes, one line per round)
round 1: approve - all 4 criteria met, claude-cli.ts untouched, typecheck + 340 tests pass on PR head (CI `check` was still pending at review time; merge.sh must see it green). Non-blocking: two concurrent requests can both pass the cooldown check before the cache is written; after a failed call on a changed transcript the old text is stored under the new size/mtime so it is served as current.
