---
id: T-021
repo: claude-dashboard
owner: eng-claude-dashboard-T-021
brief: F-003
depends_on: [T-019]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
