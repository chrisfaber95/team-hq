---
id: G-090
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-089]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
L_MainMenu greybox map, GameDefaultMap, menu and new-game map config.

## Acceptance
- [ ] Game starts on the start screen
- [ ] New Game loads the first level; Quit to menu returns here
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Assets: /Game/Maps/L_MainMenu plus map settings in Config. Plain greybox background.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
