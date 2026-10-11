---
id: T-074
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
The session-summary setting (`#summary-mode` select and its note) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/settings/summary-setting.vue` loads and saves `/api/settings/summary` like `settings.view.ts`, with the same options (`SUMMARY_MODES`) and status text
- [ ] The "needs commands" note follows `features.commands` from the store, so `updateSummaryNote` and its call in `controls.view.ts` go
- [ ] `settings.view.ts` deleted; component test covers load, change and the note
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Removing the one call in `controls.view.ts` is part of this ticket.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
