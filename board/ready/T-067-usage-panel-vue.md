---
id: T-067
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-063]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
The Token usage (14 days) popup panel is a Vue component with the same chart, legend and interactions.

## Acceptance
- [ ] `features/usage/usage-panel.vue` mounted into `#usage`: same bars, series colours, legend and totals as `usage.view.ts`; sizes through `:style`
- [ ] The click behaviour `initUsage()` wires today (a document click handler) lives in the component as template events; no document listener left
- [ ] Derives only while the popup is open (T-063); `usage.view.ts` and its `app.ts` wiring deleted; component test in `tests/client/features/usage/` covers render, an update and the click behaviour
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `usage.logic.ts` keeps its tests. `tokensToday` lives in `popups.logic.ts` (limits uses it); leave it there.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).
- First popup panel: copy T-064 (`board/done/T-064-projects-panel-vue.md`, "Next popup panel should copy").

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
