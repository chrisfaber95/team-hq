---
id: T-073
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-070, T-072]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 2
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: 89
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
PR #89 https://github.com/chrisfaber95/claude-dashboard/pull/89. `alerts-panel.vue` replaces `alerts.view.ts`: list, dismiss, threshold form, count, header badge (Teleport into `#alert-badge`, now an empty `display: contents` slot) and toasts (`alert-toast.ts`). `#alerts` in index.html is an empty host div; the component renders `<section class="panel alerts">` inside it so `has-alerts` toggles. Pending requests use `permission-requests.vue` (context `alerts`). Deleted `permissionItemsHtml`, `pendingCount`, `requestItemHtml`, the document click handler and the `initPermissions` redraw callback; 3 files left TYPE_SAFETY_LEGACY_FILES. typecheck, lint, test (553) and build pass.
Reviewer/user should look at: badge position in the header and the panel highlight/spacing in skins Classic, Co-pilot, Root, light and dark (no browser here); the extra wrapper div around the panel in the grid.
Rework (round 1): merged origin/main (27de5e8) into team/T-073, merge commit fba5676, pushed to PR #89. One conflict, `src/client/app/app.ts`: kept main's DevicesPanel/AuditPanel mounts, dropped renderAlerts and the `initPermissions` redraw callback; no other changes. typecheck, lint, test (node 471, vitest 105) and build pass.

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met, no stale references, tests cover list/dismiss/threshold/badge/toasts; CI was still pending at review time (merge.sh gates on it); visual skin check left to the user.
- lead: round 1 approved, but PR #89 conflicts with main (T-075, T-076 and others merged). Rework = merge origin/main into team/T-073, resolve (keep both sides), re-run checks, push. No other changes. Write your note inside the Hand-off section, not under a new heading.
round 2: approve - merge only brought in main's DevicesPanel/AuditPanel mounts alongside AlertsPanel; diff vs main is still scoped to the ticket, no stale references to deleted symbols, permission-requests.vue owns decide; CI was still pending at review time (merge.sh gates on it); visual skin check left to the user.
