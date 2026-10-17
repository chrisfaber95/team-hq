---
id: T-079
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/87
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
The Launch a task popup is now `features/controls/run-panel.vue` (PR #87), mounted into the empty `<section id="run">`. Same ids and classes, so skins need no change. It reads projects, permission modes and live sessions from the dashboard-state store; Recent launches load on mount, on popup open and after a successful start. `run-form.view.ts`, `launches.view.ts` and the `#run` markup are deleted and the legacy lint entry removed. `launch.logic.ts` is untouched. New component spec covers submit, empty goal, declined confirm, failed start, recent list and running state. typecheck, lint, npm test (471 node, 65 vitest) and build pass.

Reviewer / user to look at: no browser in this run, so check the popup in skins Classic, Co-pilot, Root, light and dark: the select and textarea layout, the Recent launches rows (dot, running/failed colours, View button), and that `updateControls` still hides the section when commands are off. Recent-launch times now use RelativeTime, so they tick between pushes. The commit trailer says plain "Claude" per the repo memory rule.

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met; typecheck and vitest pass locally in the worktree (CI still pending at review time, merge.sh gates on it); browser check of skins/light/dark still for the user.
