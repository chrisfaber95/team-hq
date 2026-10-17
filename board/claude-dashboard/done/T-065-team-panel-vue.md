---
id: T-065
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-063]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/83
---
## Goal
The Team board popup panel is a Vue component with the same look and behaviour.

## Acceptance
- [ ] `features/team/team-panel.vue` mounted into `#team`: tiles per column, In progress / Review / Blocked lists, Needs you (or "Nothing needs you.")
- [ ] No board in the state: nothing renders and the popup button hides (through T-063's state rule, not the section's `hidden`)
- [ ] `team.view.ts` and its render steps in `app.ts` are deleted; component test in `tests/client/features/team/` covers board, no board and an update
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Copy T-064 (first popup panel) if it has merged by then.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).
- First popup panel: copy T-064 (`board/done/T-064-projects-panel-vue.md`, "Next popup panel should copy").

## Hand-off (engineer writes, max 300 tokens)
PR #83: https://github.com/chrisfaber95/claude-dashboard/pull/83. `features/team/team-panel.vue` (mounted into `#team`) replaces `team.view.ts`; same classes and DOM (tiles, In progress/Review/Blocked lists, Needs you / "Nothing needs you."). Copies T-064: content derived only while the Team popup is open; no board in the state renders nothing, and the popup button hides through `popups.logic.ts` (`hasTeamBoard`). Removed `hidden` from `#team` in `index.html`, the render step and `drawPopup` branch in `app.ts`; architecture.md updated. `team.view.ts` was not in `TYPE_SAFETY_LEGACY_FILES`. typecheck, lint, test (463 node + 34 component), build green; CI pending when handed off.

Reviewer / user should look at (no browser run): Team popup in skins Classic, Co-pilot, Root, light and dark: tiles, lists, "Needs you"; popup button hidden when there is no team-hq board.

## Review (reviewer writes, one line per round)
round 1: approve
