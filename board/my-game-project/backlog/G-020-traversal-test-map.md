---
id: G-020
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-019]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
A test map with one example each of ladder, climbable wall, ledge, block and whip anchor in a row, passable without debug tools.

## Acceptance
- [ ] In one row: a ladder, a climbable wall, a ledge route, a pushable block puzzle and a whip anchor over a 6 m+ gap; each uses its marked volume with a visible cue.
- [ ] A player can pass the row start to end in both views, using only normal input.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets: `/Game/Maps/Greybox/L_Traversal` (new, same method as G-008: the Python commandlet, with the editor stopped through `unreal-editor.sh stop`). Place the volumes and block actors by class.
- Do not edit `L_Greybox`; this is a separate map.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
