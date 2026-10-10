---
id: T-051
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-050]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every ticket for now, 2026-10-10
pr:
---
## Goal
Vue components can read the live dashboard state: a typed reactive store in `src/client/app/` is updated by every state push, and a helper mounts a component into an existing page section.

## Acceptance
- [ ] Every push from `state-stream.ts` updates the store; a component reading it re-renders without a page reload (unit test on the store; the mount helper is tested here or covered by T-052)
- [ ] The store holds `DashboardState` from `src/shared/types` with no `any`, `as` (except `as const`) or `!`; the parsed push is checked as `unknown` before it is stored
- [ ] The existing vanilla `render()` in `app.ts` keeps working unchanged next to it
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007, step 2. Files go in `src/client/app/` (0006 folder map). Use `shallowRef` for the whole state (it is replaced on every push, every 2 s) and `computed` for derived values.
- `state-stream.ts:14` already parses to `unknown`: reuse that check, don't add a second one.
- T-050 merged: Vite 8 + Vitest 5, a sample `.vue` component test shows the setup; templates go inside the `.vue` file (user, 2026-10-10). T-061 (shared `isRecord` in `src/shared/`) runs in parallel: if it has merged when you start, use it.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
