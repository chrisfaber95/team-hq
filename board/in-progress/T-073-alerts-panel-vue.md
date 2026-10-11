---
id: T-073
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-070, T-072]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
The Alerts panel (list, dismiss, threshold setting, badge) is a Vue component, and the last string-built permission markup goes.

## Acceptance
- [ ] `features/alerts/alerts-panel.vue` covers what `alerts.view.ts` renders in `#alerts` plus the badge and count; pending requests through `permission-requests.vue` (context `alerts`)
- [ ] Dismiss and the threshold form call the same endpoints with the same status text; new-alert toasts still appear
- [ ] `alerts.view.ts`, `permissionItemsHtml`, `requestItemHtml` and the permissions document click handler are deleted, and so is the redraw callback of `initPermissions` in `app.ts`
- [ ] Component tests in `tests/client/features/alerts/` cover list, dismiss, threshold save and badge count
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `#alerts` has static markup (the form) in `index.html` today; move it into the component.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
