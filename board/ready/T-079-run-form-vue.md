---
id: T-079
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
The Launch a task popup (run form and Recent launches) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/controls/run-panel.vue` covers `run-form.view.ts` and `launches.view.ts`: project, mode, goal, notes; an empty goal is refused; Recent launches the same on every device
- [ ] Shown only when commands are allowed; same toasts and status after a launch
- [ ] `run-form.view.ts`, `launches.view.ts` and the `#run` markup in `index.html` deleted; component test covers submit, empty goal and the recent list
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `launch.logic.ts` (`features/launch/`) keeps its tests. The toast may stay in `toast.view.ts` for now (T-081).
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
