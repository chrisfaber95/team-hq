---
id: T-084
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-064, T-065, T-066, T-067, T-071, T-075, T-077, T-078, T-079]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/99
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
PR #99: https://github.com/chrisfaber95/claude-dashboard/pull/99
- New `features/popups/popup-shell.vue`: popup bar buttons plus a teleported `.popups` overlay with one dialog per `POPUPS` entry (label, Close, `aria-*`) hosting each panel; chat also hosts the summary setting. Mounted on `#popup-bar` in `app.ts`, which no longer mounts the nine panels itself.
- Deleted `popups.view.ts`, `draws()`, `drawsSection`/`openPopup` and the popup blocks in `index.html`. `controls-visibility` no longer toggles `#run` (the button visibility rule covers it). Same ids and classes, so skins are untouched.
- Checks: typecheck, lint, `npm test` (477 node + 160 vitest) and build green. New `popup-shell.component.spec.ts` covers open, switch, toggle, focus return, backdrop, Esc order, availability.
- Reviewer: Esc order (building/drawer first, popup next press), focus return, Teleport to body (z-index 3 vs building 4).
- User should look at (no browser here): skins Classic, Co-pilot, Root, light and dark; popup layout, close button, focus ring, Esc.
- Commit trailer used plain "Claude" per the user's memory rule.

## Review (reviewer writes, one line per round)
round 1: approve - criteria met, no leftover refs to removed ids/functions, tests cover open/switch/toggle/focus/backdrop/Esc/availability; CI `check` was still pending at review time (merge.sh gates on it). Non-blocking: docs/architecture.md line 46 still mentions popups.view.ts and `#popups`.
