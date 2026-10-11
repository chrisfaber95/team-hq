---
id: T-052
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-051]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every ticket for now, 2026-10-10
pr: 73
---
## Goal
The limits panel is the first Vue component and the pattern every later panel copies: same look and behaviour, markup in an indented HTML template, no string-built HTML.

## Acceptance
- [ ] The limits section renders from a `features/limits/` Vue component fed by the T-051 store, with the same markup, classes and live updates as today (no flicker; skins Classic, Co-pilot and Root unchanged)
- [ ] `limits.view.ts` and its `renderLimits` call in `app.ts` are deleted; `limits.logic.ts` keeps its `node:test` tests
- [ ] The template is normally indented HTML inside the `.vue` file (`vue-tsc` does not check `<template src>`, T-050; user agreed 2026-10-10); no `v-html`, no `any`, `as` (except `as const`) or `!`
- [ ] `docs/code-style.md` gets a short "Vue panel" section naming this panel as the example
- [ ] A Vitest + `@vue/test-utils` component test in `tests/client/features/limits/` covers the panel rendering a state and updating on the next push
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007, step 2. Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills (T-059). Limits is small and read-only, so it is the pilot panel.
- T-051 merged with a local `isRecord` in `src/client/app/dashboard-state.ts` (T-061 had not landed). Replace it with the import from `src/shared/guards.ts`; that one-line change in `app/` is part of this ticket.
- The lead writes the other panel tickets after this merges, so keep the pattern simple and say in the hand-off what the next panel should copy.

## Hand-off (engineer writes, max 300 tokens)
PR #73 https://github.com/chrisfaber95/claude-dashboard/pull/73: the limits panel is now `features/limits/limits-panel.vue` (inline indented template, reads the T-051 store via `useDashboardState()`, same classes/DOM, time spans keep `data-time`/`data-ms` so `tickTimes()` works). `limits.view.ts` and its render step are gone; `app.ts` calls `mountComponent(LimitsPanel, 'limits')` once. `dashboard-state.ts` uses `isRecord` from `shared/guards.ts`. `docs/code-style.md` has a "Vue panel" section. Component test in `tests/client/features/limits/`. typecheck, lint, test, build pass.
Next panel should copy: keep the empty `<section id>`, mount once in `app.ts`, derive with `computed` from the store, pure helpers stay in `*.logic.ts`, `:style` for dynamic widths, test = set store, mount, push new state.
Reviewer look at: not checked in a browser or per skin (no browser in this run), so verify the three skins visually; fragment root (no wrapper element) inside `#limits`; bundled a one-line lint fix in `tests/server/http/static-files.test.ts` (T-053 left an `as` assertion that failed lint on main).

## Review (reviewer writes, one line per round)
