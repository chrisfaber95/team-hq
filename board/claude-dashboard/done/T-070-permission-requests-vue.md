---
id: T-070
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-062]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: 78
---
## Goal
Pending permission requests (Allow / Deny) are one Vue component that the sessions and alerts panels use, with the same rules as today.

## Acceptance
- [ ] `features/permissions/permission-requests.vue` takes a context (`sessions` or `alerts`) and renders the same items as `permissionItemsHtml()`; buttons only where `canAnswer` allows (paired devices only, decision 0005 amendment)
- [ ] Allow / Deny call the same endpoint with the same progress and error text (`answerErrorMessage`); the answered request leaves the list on the next push
- [ ] Component tests in `tests/client/features/permissions/` cover: can answer, cannot answer (no buttons), allow, deny, an error
- [ ] `permissionItemsHtml` and the document click handler stay while T-072/T-073 still use them (T-073 deletes them)
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `auth`: approve/deny of tool runs (F-005, decision 0005). Behaviour must not change; the reviewer checks it against `permissions.view.ts`.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
Added `features/permissions/permission-requests.vue` (prop `context`: `sessions` | `alerts`) and `tests/client/features/permissions/permission-requests.component.spec.ts` (can answer, cannot answer, allow, deny, known error, unknown error). PR: https://github.com/chrisfaber95/claude-dashboard/pull/78

Reviewer: compare against `permissions.view.ts`: same endpoint `/api/permissions/:id`, `{decision}` body, `answerErrorMessage` mapping, `canAnswer`, busy until a push drops the request. The component is not mounted anywhere yet; `permissionItemsHtml` and the click handler stay (T-072/T-073). `TYPE_SAFETY_LEGACY_FILES` unchanged since the old files still exist. Checks: typecheck, lint, test all pass.

User should look at once mounted (no browser in this run): skins Classic, Co-pilot, Root, light and dark: request rows, the PC hint text, disabled buttons while busy, the error line.

## Review (reviewer writes, one line per round)
round 1: approve - matches permissions.view.ts (endpoint, body, canAnswer, answerErrorMessage, busy until push); tests cover all cases; typecheck+test pass locally in worktree, CI `check` was still pending at review time (merge.sh gates on it). Note for T-072/T-073: the component keeps its own progress map per instance, so with both lists mounted a click in one does not disable the other (old code shared one map); consider hoisting progress to shared state.
