---
id: T-072
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-062, T-070]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
The Live sessions panel is a Vue component with the same table, recent sessions and pending requests.

## Acceptance
- [ ] `features/sessions/sessions-panel.vue` mounted into `#sessions`: same table, state dots, background marks, token sums and Recent list as `sessions.view.ts`; times through T-062
- [ ] Pending requests through `permission-requests.vue` (context `sessions`, T-070)
- [ ] Session action buttons (stop, open transcript, continue) keep their `data-*` attributes so the controls' document handler works until T-081
- [ ] `sessions.view.ts` and its `app.ts` steps deleted; component test in `tests/client/features/sessions/`
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Most visible panel; keep row keys stable so scroll and focus survive pushes.
- T-070 review: `permission-requests.vue` keeps its answer progress per instance; with the sessions and alerts lists both mounted, a click in one no longer disables the other (old code shared one map). Hoist that progress to shared state here.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)

## Blocked
- lead: the first run stopped on the account session limit after 1 turn, not on the ticket. Nothing to fix: work the ticket from the start (keep any partial work in the worktree).
