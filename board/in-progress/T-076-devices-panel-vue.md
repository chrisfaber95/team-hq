---
id: T-076
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-063]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
The Devices popup panel (list, add, revoke, one-time token) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/devices/devices-panel.vue` mounted into `#devices`: same list, add form, revoke, token box with Copy and Dismiss, status and error text as `devices.view.ts`
- [ ] Shown only on this PC; the list is re-fetched on show and at most every 30 s while shown, as today
- [ ] The token is shown once and cleared on Dismiss and on close; component tests cover list, add, token, revoke and an error
- [ ] QR pairing keeps working through `devices-qr.view.ts` (T-077 migrates it)
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `auth`: device tokens (F-002, decision 0003). Behaviour must not change.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).
- First popup panel: copy T-064 (`board/done/T-064-projects-panel-vue.md`, "Next popup panel should copy").

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
