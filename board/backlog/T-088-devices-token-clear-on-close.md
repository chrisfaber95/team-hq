---
id: T-088
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-076, T-077]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
A one-time device token on screen is cleared when the Devices popup closes, not only on Dismiss, so it is never shown again on reopen.

## Acceptance
- [ ] Closing the Devices popup (Close, Esc, backdrop, opening another popup) clears the token value and hides the token box
- [ ] Reopening the popup shows no token; a component test covers show token, close, reopen
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `auth`: T-076 review found the popup Close leaves a shown token in place (pre-existing; T-076 acceptance asked "cleared on Dismiss and on close"). `features/devices/devices-panel.vue`; the open-popup id comes from `useOpenPopup()` (T-063).
- Same folder as T-077: run after it.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
