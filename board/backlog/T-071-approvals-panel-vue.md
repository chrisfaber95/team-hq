---
id: T-071
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-063, T-070]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
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

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
