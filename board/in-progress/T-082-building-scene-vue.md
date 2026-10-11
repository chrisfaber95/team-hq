---
id: T-082
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

## Review (reviewer writes, one line per round)
