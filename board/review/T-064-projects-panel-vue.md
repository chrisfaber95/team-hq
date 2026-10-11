---
id: T-064
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-062, T-063]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/79
---
## Goal
The Projects popup panel is a Vue component with the same look and behaviour.

## Acceptance
- [ ] `features/projects/projects-panel.vue` mounted into `#projects`, same markup and classes as `projects.view.ts` (cards, project colours, token counts, relative times via T-062)
- [ ] It derives its content only while the Projects popup is open (T-063); opening it shows current data at once
- [ ] `projects.view.ts`, its render step and its `drawPopup` branch in `app.ts` are deleted; component test in `tests/client/features/projects/`
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Small read-only panel and the first popup panel: say in the hand-off what the next popup panel should copy.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
PR #79: https://github.com/chrisfaber95/claude-dashboard/pull/79. `features/projects/projects-panel.vue` (mounted into `#projects`) replaces `projects.view.ts`; same markup and classes, relative times via `RelativeTime`. Pure helpers in `projects.logic.ts`. Render step and `drawPopup` branch removed from `app.ts`; architecture.md updated. typecheck, lint, test (463 node + 20 component), build green.

Next popup panel should copy: read `useOpenPopup()` and have the `computed` return `[]`/null unless its id is open (opening shows current data at once because `setOpenPopup` runs in `show()` before Vue flushes); keep the `<h2 id="h-...">` always rendered (section has `aria-labelledby`); delete its `draws()` step and `drawPopup` branch. Colour through `:style`.

Reviewer / user should look at (no browser run): Projects popup in skins Classic, Co-pilot, Root, light and dark: card look, swatch colour, live badge, "not trusted" tooltip, click and Enter on a card opens the building and Esc returns focus to the card. Note: cards leave the DOM while the popup is closed; branch is one commit behind main (T-070), unrelated.

## Review (reviewer writes, one line per round)
