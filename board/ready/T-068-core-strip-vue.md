---
id: T-068
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
The live "core" strip (Co-pilot and Root skins) is a Vue component, and the 2 s pushes still never restart its CSS animations.

## Acceptance
- [ ] `features/core/core-strip.vue` mounted into `#core`, same markup and classes as `core.view.ts`, mood and headline from `mood.logic.ts`
- [ ] A push that changes nothing leaves the DOM untouched; a mood change only swaps class and text (the component test checks the animated element is the same node across pushes)
- [ ] `core.view.ts` and its `app.ts` wiring deleted; T-060's throwaway `tests/client/features/core/click-counter.*` removed if nothing else uses it
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Animation restarts were why F-004/T-037 patch the DOM; keep elements keyed and stable.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
