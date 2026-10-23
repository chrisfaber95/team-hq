---
id: G-091
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-083, G-090]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
Place checkpoints in L_CombatArena and L_Traversal.

## Acceptance
- [ ] Reaching a checkpoint autosaves; Continue after restart restores state there
- [ ] Death before any checkpoint restarts the level
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Assets: /Game/Maps/L_CombatArena, L_Traversal. Babylon level checkpoints belong to F-012.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
