---
id: T-071
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-063, T-070]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/95
---
## Goal
The Approvals popup panel (approval log with Refresh) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/permissions/approvals-panel.vue` mounted into `#approvals`: loads `/api/approvals` when the popup opens and on Refresh; same list, status and error text
- [ ] Shown only when commands are allowed (T-063 state rule)
- [ ] `renderApprovals`, `updateApprovals` and the approvals part of `initPermissions` deleted; component test covers load, refresh and an error
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `auth` (F-005 approval log). The response is checked as `unknown`, not trusted through a generic.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).
- First popup panel: copy T-064 (`board/done/T-064-projects-panel-vue.md`, "Next popup panel should copy").

## Hand-off (engineer writes, max 300 tokens)
PR #95: https://github.com/chrisfaber95/claude-dashboard/pull/95. `features/permissions/approvals-panel.vue` (mounted into `#approvals`) replaces `permissions.view.ts`; loads `/api/approvals` on popup open and Refresh, renders only while `features.commands` is on, fixed error text, stale responses ignored. Response is checked as `unknown` by `approvalEntriesOf` in `permissions.logic.ts`; HTML builders removed, `permissions.logic.ts` left `TYPE_SAFETY_LEGACY_FILES`. typecheck, lint, test (478 node + 120 component) green; build not run.

Reviewer / user should look at (no browser run): Approvals popup in skins Classic, Co-pilot, Root, light and dark: row layout, outcome colours (allow/deny/expired/unknown), Refresh and status text. The section lost its `hidden` attribute and is empty when commands are off. The PR has two commits (the first holds only the `permissions.view.ts` deletion); squash on merge.

Rework (merge conflict): merged origin/main into team/T-071 (merge commit 78697c0, pushed). Conflicts only in `eslint.config.js` (kept union of legacy-list removals) and `src/client/app/app.ts` (kept main's MessagesPanel; dropped approvals render step, `drawPopup` and `initPermissions()`; `initPopups` now gets a no-op callback, which the reviewer may want shaped differently). Local on merged tree: typecheck, lint, test (478 node + 134 component), build green. CI `check` was still pending when I handed off.

## Review (reviewer writes, one line per round)
- lead: approved, but PR #95 conflicts with main after other panels merged. Rework = merge origin/main into team/T-071, resolve (keep both sides), re-run typecheck/lint/test, push. No other changes. Write your note inside the Hand-off section, not under a new heading.
- round 1: approve
