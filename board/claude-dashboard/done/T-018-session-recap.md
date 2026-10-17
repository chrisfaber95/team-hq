---
id: T-018
repo: claude-dashboard
owner: eng-claude-dashboard-T-018
brief: F-003
depends_on: [T-017]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: false
pr: https://github.com/chrisfaber95/claude-dashboard/pull/33
---
## Goal
"Summarize session X" in the chat gives a quick recap of what the session did, without a model.

## Acceptance
- [ ] `GET /api/sessions/:id/summary` (signed-in, same id checks as `/transcript`) returns `{ mode: 'recap', text }` built from the transcript: started, last activity, status, token totals, the last 5 tool actions (tool + short target, e.g. "Edit src/server/auth.ts", "Bash: npm test") and the last assistant message cut to 300 chars
- [ ] Reads at most the tail the transcript viewer already reads; unknown session -> 404 with a fixed string
- [ ] The chat's `summary` intent calls it and shows the text; tokens only, never cost
- [ ] Harden the chat forbidden-endpoint test (T-017 review note): it must also catch an endpoint path built without an `/api/` literal; `/api/sessions/:id/summary` is the only new endpoint the chat may call
- [ ] Tests with a fixture transcript for the recap fields and the 404; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0004-chat-without-a-model.md`. Build on `src/server/transcript-view.ts`. Tool inputs can
hold secrets or long text: show only the tool name and a short, cut target (file path, first 60 chars of a command).
Leave a seam for T-019's model mode (e.g. a `summarize(id, mode)` function).
Run 1 (2026-10-09) stopped on the account session limit, not on the ticket: its uncommitted work is in the worktree (`session-summary.ts`, its test, edits to chat/server/types). Continue from it; there are no review points yet.

## Hand-off (engineer writes, max 300 tokens)
PR #33 (https://github.com/chrisfaber95/claude-dashboard/pull/33). Run 2 had no review points; continued run 1's work.
- `GET /api/sessions/:id/summary` -> `{mode:'recap',text}` via new `src/server/session-summary.ts` (`summarize(path, mode)` seam for T-019); UUID 400 / unknown 404 fixed strings; reads the viewer's tail cap.
- Chat `summary` intent now calls it (was a "coming soon" stub).
- Chat endpoint test now checks the first argument of every `api()` call and bans fetch/XHR/EventSource, so paths built without an `/api/` literal are caught.
- security-auditor ran: no high findings; medium (secrets echoed in Bash/URL targets) fixed by masking.
- typecheck clean, 330 tests pass, build ok. Not browser-tested.
Look at: `redact()` regexes, "Last reply" may quote secrets the model printed (same as the viewer).

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met; typecheck + 330 tests pass locally in the worktree. CI was still pending at review time, so merge.sh must wait for green.
