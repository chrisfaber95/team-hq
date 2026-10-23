---
id: G-087
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-083, G-084, G-085, G-086]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
C++ widget bases for start, pause, death and settings screens.

## Acceptance
- [ ] Start: New Game, Continue (only with save), Settings, Quit
- [ ] Pause: Resume, Restart from checkpoint, Settings, Quit to menu; Death: Retry, Quit to menu
- [ ] Settings widget exposes view, FOV, sensitivity and remapping, reachable from start and pause
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. UI/ module; layout-only WBPs come in G-089. No confirmation dialogs. Keyboard and mouse navigation.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
