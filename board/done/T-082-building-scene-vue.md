---
id: T-082
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: 81
---
## Goal
The building scene (rooms, annex, cubicles) is drawn by Vue components instead of HTML strings.

## Acceptance
- [ ] `features/building/building-scene.vue` (plus room and annex components) render the same markup and classes as `building-scene.view.ts`, `building-room.view.ts` and `building-annex.view.ts` for one project
- [ ] `building.view.ts` mounts the scene into `#building-body` once and the scene updates from the store, replacing the `sceneHtml` redraw (`buildingRedrawKey` goes if nothing else needs it)
- [ ] The three scene view files deleted; component tests cover sessions, subagents, an empty project and an update
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `building.logic.ts` keeps its tests. The dialog itself is T-083.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
PR #81 https://github.com/chrisfaber95/claude-dashboard/pull/81. The building scene is now Vue: building-scene.vue mounts once into #building-body and reads the store plus the open project/tint from building-selection.ts; room, empty-room, annex and cubicle components; pure positions and pipe paths in building-layout.logic.ts (node:test). building.view.ts only sets title/subtitle and the open building; the three scene *.view.ts, buildingRedrawKey and tooltipAttribute are deleted, building.view.ts also left TYPE_SAFETY_LEGACY_FILES. Markup parity with the old string output was checked once with a throwaway test (empty, one session, six sessions with nested subagents): identical. Checks: typecheck, lint, npm test (466 node + 30 component), build all pass.
Reviewer: no browser was available. Look at the building popup in Classic, Co-pilot and Root skins, light and dark: animations (typing, bubbles, mail), pipes, tick, tooltips, click/Enter opening transcripts, focus after a push. PR title keeps the ticket-id format, not conventional-commit.

## Review (reviewer writes, one line per round)
round 1: approve - matches acceptance; CI "check" was still pending at review time (merge.sh gates on it); browser look in Classic/Co-pilot/Root, light and dark still owed by the user.
