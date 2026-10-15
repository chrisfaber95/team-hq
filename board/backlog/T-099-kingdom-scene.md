---
id: T-099
kind: ticket
repo: claude-dashboard
base: epic/F-008
branch:
owner: eng-claude-dashboard
brief: F-008
depends_on: [T-098]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:
---
## Goal
The Session communication popup draws the kingdom from T-097/T-098 instead of the F-007 city: grass, dirt
paths, the square with well and stalls, the wall with towers, trees, the castle and the session buildings with
roofs and labels. Movement comes in T-100; the feed is unchanged.

## Acceptance
- [ ] Scene: isometric SVG with ground, paths, square (well, market stalls), wall ring with towers, trees, the
      castle (clearly bigger and different from any building) and one building per session with a roof,
      labelled with its name; the four building kinds look different (`hall` tallest)
- [ ] Castle marker: a flag/banner shows on the castle exactly when `needsYou` is true (component test both ways)
- [ ] States without reading: `active` has lit windows (and a chimney smoke element), `idle` is unlit with the
      "idle N min" label, `stopped` is shut (closed door/shutters, greyed) with "stopped"; workers stand at their
      parent building with the "+N more" count; finished subagents are not shown
- [ ] Wide layout when the scene area is wider than tall, tall layout (vertical scroll, castle on top) otherwise;
      the feed shows the same last 40 messages; nothing is computed while the popup is closed (as today)
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `src/client/features/messages/`: new `kingdom-view.vue` (split into small components if it passes the
  size limits) and `_kingdom.scss`; remove `city-view.vue`, `city-layout.logic.ts`, `_city.scss` and their
  tests; `messages-panel.vue` switches to the new view. Mailmen may stand at their sender's door until T-100.
- Follow `docs/isometric.md` (three layers, depth order, `iso-tint-N`, lit faces) and "UI conventions" in
  `docs/architecture.md`: no inline styles in new code, no `v-html`, light and dark, skin tokens.
- Look: the brief's "The kingdom" section; the user's reference is mood only, drawn with code (no image files,
  no third-party art). Keep it simple; the user judges the look in the browser, not the reviewer.
- Pick wide/tall with a `ResizeObserver` or `matchMedia` on the scene area, not a timer.
- No CPU measurement in this brief (user, 2026-10-15).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
