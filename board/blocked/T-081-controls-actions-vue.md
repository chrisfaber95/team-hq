---
id: T-081
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-072, T-080]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
`controls.view.ts` goes: session actions (stop, continue, open) are called from the Vue panels instead of a document click handler.

## Acceptance
- [ ] Stop, continue and open-transcript are plain functions in `features/controls/` that the sessions panel (T-072) and the building call from template events; same endpoints, confirms and toasts
- [ ] Logout button visibility and the mode options follow the store; no document click handler left in `features/controls/`
- [ ] `controls.view.ts` and `toast.view.ts` (now a component or composable) deleted; tests cover stop, continue and an error
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Continue touches T-031's session control, but this is a move, not a behaviour change; the reviewer checks the endpoints are unchanged.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)

## Blocked
- lead: the first run stopped on the account session limit after 3 turns, not on the ticket. Nothing to fix: work the ticket from the start (keep any partial work in the worktree).
