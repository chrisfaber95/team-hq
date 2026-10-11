---
id: T-070
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-062]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
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

## Review (reviewer writes, one line per round)
