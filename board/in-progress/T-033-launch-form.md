---
id: T-033
repo: claude-dashboard
owner: eng-claude-dashboard-T-033
brief: F-006
depends_on: [T-032, T-027]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The owner launches new work from the dashboard with a project, a goal and background notes, sees it start, and sees
what they launched from any device.

## Acceptance
- [ ] The "Run a task" popup becomes a launch form: project, goal, optional background notes (separate field),
      permission mode from the modes offered today (no bypass); it posts `project`, `goal`, `notes`, `mode` (T-032)
- [ ] Empty goal or no project: the form shows the server's message next to the form and starts nothing; a failed
      start shows the reason; typed goal and notes are kept after a failure and cleared after a success
- [ ] After a success the new session appears in live sessions within a few seconds, and the launch list marks it
      running / not live with a View button that opens its transcript
- [ ] "Recent tasks" (localStorage) is replaced by "Recent launches" from `GET /api/launches` (time, project, goal,
      device), the same on every device; the old localStorage key is removed
- [ ] Pure form/list logic is unit-tested; `npm run typecheck` and `npm test` pass

## Notes (lead)
Brief F-006. Today: `#run` form in `src/client/index.html`, run panel + recent tasks in `src/client/controls.ts:147-245`.
T-027 moves the run panel into a popup; build on that. Updates go through the in-place patcher from T-026
(`src/client/patch.ts`). No model/effort pickers, presets or scheduling (out of scope).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
