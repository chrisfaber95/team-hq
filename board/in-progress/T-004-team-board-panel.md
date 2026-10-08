---
id: T-004
repo: claude-dashboard
owner: eng-claude-dashboard
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
