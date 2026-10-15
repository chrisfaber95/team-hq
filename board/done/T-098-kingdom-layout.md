---
id: T-098
kind: ticket
repo: claude-dashboard
base: epic/F-008
branch:
owner: eng-claude-dashboard
brief: F-008
depends_on: [T-097]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr: 111
---
## Goal
A pure, tested isometric layout of the kingdom on the `shared/iso.ts` grid: castle, square, court, districts,
paths, wall with towers and trees, in a wide (desktop) and a tall (phone) arrangement, plus the cell route each
mailman walks. No rendering (T-099 draws it).

## Acceptance
- [ ] Wide layout: castle at the centre beside a central square (well + market stall cells); court buildings on
      cells around the square; each district on its own plot around them, separated from the others by path
      cells; a closed wall ring with tower cells around everything; tree cells on free grass
- [ ] Tall layout: castle at the top, then the court, then each district below the other; its `fitViewBox`
      width is at most 400 SVG units, so labels stay readable at 390 px
- [ ] Stable cells: a building keeps its cell while on screen; adding a building or district never moves an
      existing building, the square or the castle (the wall and trees may grow outward); test across calls
- [ ] Every building has a door on a path, and every path connects to the square; a mailman's walk is a
      `walkRoute` corner list from the sender's door to the receiver's door (or the castle gate) that only
      crosses path or square cells (test: no step over a building, wall or tree cell)
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `src/client/features/messages/`, new `kingdom-layout.logic.ts` beside `kingdom.logic.ts` (T-097); it
  replaces `city-layout.logic.ts` once T-099 drops the old view. Geometry only through `shared/iso.ts`; read
  `docs/isometric.md` ("Grid and coordinates", "Draw order", "Walking"). One building per cell; a bigger castle
  is one box per cell (the docs explain why).
- Input: the T-097 kingdom plus `'wide' | 'tall'`; the view (T-099) picks one by popup shape.
- Desktop: the wide scene scales with its viewBox to fill the popup; no zoom or scroll there.
- No CPU measurement in this brief (user, 2026-10-15).

## Hand-off (engineer writes, max 300 tokens)
Pure kingdom layout in `src/client/features/messages/`: `kingdom-layout.logic.ts` (`createKingdomLayoutTracker().arrange(kingdom, 'wide'|'tall')`, `mailmanRoute`), plus types, grid helpers (BFS walk, corners) and a wide and a tall plan. PR: https://github.com/chrisfaber95/claude-dashboard/pull/111
Look at: stable plots (lowest free plot per district, tracker state); capacities (court 20, district 12, wide 40 districts; extra buildings go to `layout.overflow` for T-099 to show as "+N"); tall has no trees (400-unit width budget, test pins it); wall/towers/trees are plain cell lists.
Ran locally: typecheck, lint, npm test (512 node + 166 vitest pass), new suite kingdom-layout.logic.test.ts (11 tests).

## Review (reviewer writes, one line per round)
round 1: approve
