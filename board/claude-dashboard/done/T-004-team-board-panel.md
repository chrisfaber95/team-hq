---
id: T-004
repo: claude-dashboard
owner: eng-claude-dashboard
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: false
pr: 18
---
## Goal
A read-only "Team" section in the dashboard shows the team-hq board at a glance: tickets per column
and the unticked items in `NEEDS-YOU.md`, so the user doesn't have to open files.

## Acceptance
- [ ] New env var `TEAM_HQ_DIR` (default `N:\team-hq`); the section is hidden when the folder or its `board/` doesn't exist
- [ ] Shows counts for backlog, ready, in-progress, review, done, blocked, plus id + title of every in-progress, review and blocked ticket, and each unticked `- [ ]` line of `board/NEEDS-YOU.md`
- [ ] Read-only: no writes anywhere under `TEAM_HQ_DIR`; every value rendered through `esc()`; malformed ticket files are skipped, not fatal
- [ ] New `DashboardState` field typed in `src/shared/types.ts`; server reader has `node:test` coverage using a fixture board in a temp dir
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
Ticket format: `N:\team-hq\board\TEMPLATE.md` (front matter `id`, `repo`; title = first line under `## Goal` or the file slug).
Follow the "UI conventions" in `docs/architecture.md`; client work goes to `frontend-developer`, types to `typescript-pro` first.

## Hand-off (engineer writes, max 300 tokens)
PR #18: https://github.com/chrisfaber95/claude-dashboard/pull/18 (not merged). Added `TEAM_HQ_DIR`, read-only `readTeamBoard()` (`src/server/team.ts`), `DashboardState.team` (null hides the section), client `src/client/team.ts`, docs, `tests/team.test.ts`.
Checks: typecheck clean, 186 tests pass, build ok. Not checked visually in a browser (layout/skins).
Look at: bounded reads (8 KB ticket head, 64 KB NEEDS-YOU), 5s cache (a board created within 5s of a null result stays hidden until it expires), malformed tickets are skipped from lists but still counted, titles/NEEDS-YOU text are served via /api/state. Commit trailer says plain "Claude" (user memory rule).

## Review (reviewer writes, one line per round)
round 1: approve
