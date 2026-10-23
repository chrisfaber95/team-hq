---
id: G-083
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-081, G-082]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Checkpoint actor autosaves; AIndyGameMode restores the saved world in StartPlay; death no longer auto-restarts.

## Acceptance
- [ ] Reaching a checkpoint autosaves once to the single slot
- [ ] StartPlay restores player position and world state from the slot
- [ ] Death does not auto-restart; it raises a death event for the death screen
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Save/IndyCheckpoint and Player/IndyGameMode. Replaces G-044 arena restart-on-death behaviour.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
