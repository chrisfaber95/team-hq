---
id: T-084
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-064, T-065, T-066, T-067, T-071, T-075, T-077, T-078, T-079]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
One Vue popup shell, generated from `POPUPS`, replaces the nine repeated popup blocks in `index.html`; popup labels exist in one place.

## Acceptance
- [ ] A `features/popups/` component renders the popup bar and one dialog wrapper per `POPUPS` entry (label, Close button, `aria-*`) hosting each panel component
- [ ] Same behaviour: one popup at a time, toggle, backdrop click, Esc order, focus back to the opener, buttons per T-063's state rule
- [ ] `popups.view.ts`, `draws()` and the popup blocks in `index.html` deleted; component tests cover open, switch, Esc and focus return
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- The labels drifted between `index.html` and `POPUPS` (decision 0007, context); `POPUPS` wins.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
