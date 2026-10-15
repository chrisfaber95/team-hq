---
id: T-091
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-007
depends_on: [T-090]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:                       # engineer fills in, e.g. 88
---
## Goal
The "Session communication" popup draws the city from T-090 instead of the all-time circle graph: open,
idle and closed shops, workers inside, postmen running between shops. The feed is unchanged.

## Acceptance
- [ ] Active, idle (labelled like "idle 12 min") and stopped (labelled "stopped", looks closed) shops are
      visibly different; workers show inside their shop with the "+N more" count; no all-time edges
- [ ] A postman moves from sender shop to receiver shop (direction readable from the movement) and is gone
      after its 30 s; a hand-back postman moves inside the shop from worker to boss
- [ ] Animation runs only while a postman is on screen: with none, no animation loop or running CSS
      animation (a test asserts it); popup closed means nothing is computed, as today
- [ ] The feed shows the same last 40 messages as before; the layout fits a 390 px wide phone without
      horizontal scroll
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `src/client/features/messages/` (`messages-panel.vue`; a new `city-*.vue` component there if the
  panel gets long). Vue + SVG, no `v-html`, template inside the `.vue` file (decision 0007).
- Prefer CSS/SVG transitions keyed by postman id over a permanent `requestAnimationFrame` loop; the F-004
  CPU gains must hold (T-093 measures). With `prefers-reduced-motion`, the postman appears at the receiver.
- Keep the shop look simple (box + awning, door shut when stopped); the user judges the look in the
  browser check, not the reviewer.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
