---
id: G-009
kind: epic
repo: my-game-project
base: main
branch: epic/F-009
owner: lead
brief: F-009
depends_on: [G-001, G-002, G-003, G-004, G-005, G-006, G-007, G-008]
contracts: []
labels: []
budget_usd: 0
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
F-009 Dual-view player (greybox): in a greybox test map the player moves, jumps, crouches, rolls and looks around, and swaps between first and third person at any time; movement is equally good in both views.

## Acceptance
- [ ] Every acceptance criterion of `product/my-game-project/briefs/F-009-dual-view-player.md` holds (feature review against the brief).
- [ ] Full CI green on the epic PR.

## Notes (lead)
Epic ticket, never dispatched. `bash scripts/epic.sh open F-009 my-game-project` before G-001; `epic.sh pr G-009` once G-001..G-008 are done.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
