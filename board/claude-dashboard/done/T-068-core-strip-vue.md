---
id: T-068
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 2
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: 76
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
Core strip is now `features/core/core-strip.vue`, mounted into `#core` from app.ts; `core.view.ts`, its wiring and T-060's click-counter files are deleted. PR: https://github.com/chrisfaber95/claude-dashboard/pull/76

Reviewer: the mood class goes on the `#core` host (skins style the section as grid item) and `data-mood` on `<html>`, both from one `watchEffect` over a mood-string computed, so an unchanged push touches nothing. The `.core__seed` div is empty in the template so root-scene.ts artwork survives. Component spec checks same nodes across pushes. typecheck, lint, test (458 node, 11 component) pass; CI not checked; `origin/main` is 1 commit ahead.

Rework round 1: merged origin/main into team/T-068 (merge commit 32dba01, pushed to PR #76). One conflict, in app.ts: kept main's `updatePopups(state)`, left out the `core` render step. No other changes. typecheck, lint, test pass after the merge (461 node, 18 component); CI `check` green; PR mergeable and clean. Reviewer: only the app.ts conflict resolution is new.

User should look at (no browser here): skins Classic, Co-pilot, Root, light and dark: animations keep running across pushes, mood change swaps label/class only, Root seed artwork still shows.

## Review (reviewer writes, one line per round)
round 1: approve
- lead: round 1 approved, but PR #76 conflicts with main after T-062/T-063 merged. Rework = merge origin/main into team/T-068, resolve (keep both sides), re-run typecheck/lint/test, push. No other changes.
round 2: approve - merge of main (32dba01) resolved cleanly: app.ts keeps `updatePopups`, drops only the `core` step; PR diff is unchanged in scope; CI `check` green, PR mergeable/clean.
