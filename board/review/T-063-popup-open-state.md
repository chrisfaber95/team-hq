---
id: T-063
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/75
---
## Goal
A Vue panel inside a popup can tell whether its popup is open, and popup buttons show from the state instead of from a section's `hidden` flag, so popup panels can migrate without touching their host section.

## Acceptance
- [ ] `features/popups/` exports a reactive read-only open-popup id (e.g. `useOpenPopup()`), updated on open and close; vanilla `draws()` keeps working
- [ ] Which popup buttons show is a pure function of the state in `popups.logic.ts` (team board present, commands allowed, devices on this PC, ...), with `node:test` tests; behaviour is the same as today
- [ ] A Vitest test shows a component reading the open-popup id re-renders on open and close
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Today: `visiblePopups(sectionHidden)` in `popups.logic.ts`, `updatePopups()` in `popups.view.ts`; the team, devices, run and approvals sections toggle `hidden` to drive the buttons.
- Popup panels (T-064..T-067, T-071, T-075) use this to compute only while open (F-004 CPU budget). The popup shell itself goes Vue in T-084.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
PR #75: https://github.com/chrisfaber95/claude-dashboard/pull/75
- New `features/popups/open-popup.ts`: `useOpenPopup()` (read-only shallowRef id) and `setOpenPopup()`, set from the shell's `show()`. Vanilla `draws()` untouched.
- `visiblePopups({hasTeamBoard, canRunCommands, canManageDevices})` is pure in `popups.logic.ts`; `updatePopups(state)` derives it from `state.team` and `state.features`, not from section `hidden`. Added `isPopupId` guard.
- `popups.view.ts` lost its `!`/`as` and left `TYPE_SAFETY_LEGACY_FILES`.
- Tests: node:test for the availability function; Vitest spec (probe component) for re-render on open, switch, close. typecheck, lint, npm test pass (461 node + 11 vitest).
- Reviewer: no browser run. Look at the popup bar in Classic, Co-pilot, Root, light and dark: with/without team board, commands off (run, approvals hidden), LAN (devices hidden). Commit subject is 73 chars (convention 72). CI was pending.

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met; button rules match today's section conditions (team, commands, manageDevices); CI `check` was still pending at review time, merge.sh must wait for green
