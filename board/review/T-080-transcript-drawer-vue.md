---
id: T-080
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-079]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 2
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/91
---
## Goal
The transcript drawer (`#drawer`) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/controls/transcript-drawer.vue` replaces `drawer.view.ts`: open transcript, subagent transcript, logs, Load earlier, the message box, Esc and Close
- [ ] `openTranscript`, `openSubagentTranscript` and `openLogs` keep their signatures for callers (chat, building, sessions)
- [ ] `drawer.view.ts` deleted; component tests cover open, load earlier, a live update and close; scroll position survives pushes
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Waits for T-079 only because both are in `features/controls/` (one ticket per module at a time).
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
PR #91: https://github.com/chrisfaber95/claude-dashboard/pull/91. `transcript-drawer.vue` replaces `drawer.view.ts` (deleted, off `TYPE_SAFETY_LEGACY_FILES`). Same `#drawer` DOM/ids, so skins and the building/popup Esc checks are untouched. `openTranscript`/`openSubagentTranscript`/`openLogs` keep signatures (store in `transcript-drawer-selection.ts`, re-exported by `controls.view.ts`). Pure `mergeLiveTail`/`isLiveElsewhere` in `transcript-drawer.logic.ts`. Checks: typecheck, lint, npm test pass (node 476, component 89). 9 component tests + 5 logic tests.
Reviewer: scroll stickiness on poll and Load earlier (happy-dom has no layout, so tested with stubbed sizes); permission-mode select now keeps its choice across pushes. Branch is 1 commit behind main (not rebased).
User should look at (no browser here): drawer in Classic, Co-pilot, Root, light and dark; Load earlier keeps position; Esc closes drawer before building/popup.

## Review (reviewer writes, one line per round)
round 1: changes - in transcript-drawer.vue `refreshTranscript` never clears `loadError` after a later successful poll, so a failed first load stays on "error" forever (the old drawer recovered on the next poll); clear `loadError` on success and add a component test for fail-then-recover. Everything else meets the acceptance criteria; CI green.
round 1 rework: `refreshTranscript` now clears `loadError` after a successful poll; new component test "recovers from a failed first load on the next poll". Commit 0d294fe pushed to PR #91. typecheck, lint, npm test pass (node 476, component 90).
round 2: approve - loadError now clears on a successful poll and the recovery test covers it; all acceptance criteria met; typecheck and npm test re-run green on 0d294fe (CI reports only GitGuardian).
