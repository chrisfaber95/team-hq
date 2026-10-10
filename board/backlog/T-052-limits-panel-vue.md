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
user_ok: false
pr:
---
## Goal
The limits panel is the first Vue component and the pattern every later panel copies: same look and behaviour, markup in an indented HTML template, no string-built HTML.

## Acceptance
- [ ] The limits section renders from a `features/limits/` Vue component fed by the T-051 store, with the same markup, classes and live updates as today (no flicker; skins Classic, Co-pilot and Root unchanged)
- [ ] `limits.view.ts` and its `renderLimits` call in `app.ts` are deleted; `limits.logic.ts` keeps its `node:test` tests
- [ ] The template is normally indented HTML (a `<template src>` file if T-050 proved it is type-checked, otherwise inside the `.vue` file); no `v-html`, no `any`, `as` (except `as const`) or `!`
- [ ] `docs/code-style.md` gets a short "Vue panel" section naming this panel as the example
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007, step 2. Limits is small and read-only, so it is the pilot panel.
- The lead writes the other panel tickets after this merges, so keep the pattern simple and say in the hand-off what the next panel should copy.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
