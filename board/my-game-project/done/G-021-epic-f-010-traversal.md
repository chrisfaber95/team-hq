---
id: G-021
kind: epic
repo: my-game-project
base: main
branch: epic/F-010
owner: lead
brief: F-010
depends_on: [G-011, G-012, G-013, G-014, G-015, G-016, G-017, G-018, G-019, G-020]
contracts: []
labels: []
budget_usd: 0
review_rounds: 1
user_check: false
user_ok: false
pr: 25
---
## Goal
F-010 Traversal: the player crosses marked obstacles with ladders, climbable walls, ledge hangs, push/pull blocks and the whip swing, in both camera views, in a test map.

## Acceptance
- [ ] Every acceptance criterion of `product/my-game-project/briefs/F-010-traversal.md` holds (feature review against the brief).
- [ ] Full CI green on the epic PR.

## Notes (lead)
Epic ticket, never dispatched. `bash scripts/epic.sh open F-010 my-game-project` once F-009 is on `main` and before G-011 is dispatched; `epic.sh pr G-021` once the others are done.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
round 1: approve
