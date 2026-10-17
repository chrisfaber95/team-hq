---
id: T-032
repo: claude-dashboard
owner: eng-claude-dashboard-T-032
brief: F-006
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_ok: false
pr: 43
---
## Goal
The server can start a session from a project, a goal and optional background notes, refuses bad launches with a
clear reason, and keeps a launch history every device can read.

## Acceptance
- [ ] `POST /api/commands` (start) takes `project`, `goal`, optional `notes` and `mode`; the session gets one prompt
      with the goal and the notes in clearly marked sections (goal first; no notes section when empty); length limits
      stay as today for the total
- [ ] Missing project, unknown project, or an empty/whitespace goal -> 400 with a fixed, readable message and no CLI
      call; `bypassPermissions` still refused; same access as today (signed-in device, commands enabled)
- [ ] A failed start returns the reason (as today's error path) and leaves no session behind; the response says so
- [ ] Each launch is audited with time, device, project, mode, the goal (up to 500 chars), notes length (not the
      notes text), ok and session id; `GET /api/launches` returns the latest 50 launches from the audit log, newest
      first, same access as `/api/audit`
- [ ] Tests for compose, validation (each refusal: no CLI call), failure path, audit entry and `/api/launches`;
      `npm run typecheck` and `npm test` pass

## Notes (lead)
Brief: `team-hq/product/briefs/F-006-launch-with-context.md`. Today: `src/server/server.ts:445-453` (start, audit with
`prompt.slice(0, 200)`), `startTask` in `src/server/claude-cli.ts:141`, audit in `src/server/audit-log.ts`. Lead's
technical choice: notes travel inside the prompt (marked section), not via a system-prompt flag, so `claude-cli.ts`
stays unchanged; don't touch it. Keep accepting the old `prompt` field until T-033 ships the new form (treat it as the
goal). Server only: the form is T-033. Don't run alongside T-031 (also edits `server.ts`).

## Hand-off (engineer writes, max 300 tokens)
PR: https://github.com/chrisfaber95/claude-dashboard/pull/43 (not merged). typecheck pass, npm test 371/371.
- New `src/server/launch.ts`: `composeLaunch` builds one prompt (`## Goal`, then `## Background notes` only if notes non-empty); old `prompt` field = goal; fixed 400 messages, no CLI call on refusal; 20000 total limit.
- `POST /api/commands` response adds `started` (false on failed start = no session left).
- Audit start entry: `goal` (500), `notesLength`, `session`; `prompt` no longer written (existing tests updated).
- `GET /api/launches`: latest 50 starts, newest first, same access as `/api/audit`.
- `claude-cli.ts` untouched. `types.ts` got small additions (done directly, not via typescript-pro).
Reviewer: look at `launch.ts`, the `/api/commands` block in `server.ts`, and the action filter in `audit-log.ts`. Old log lines with `prompt` and no `goal` still appear in launches.

## Review (reviewer writes, one line per round)
round 1: approve
