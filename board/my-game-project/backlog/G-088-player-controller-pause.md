---
id: G-088
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-087]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
AIndyPlayerController handles pause (full world freeze via SetGamePaused) and input modes, owns the widgets; AIndyMenuGameMode.

## Acceptance
- [ ] Pause key opens the pause menu in any state and freezes AI, physics, air meter and timers
- [ ] Resume unfreezes; Quit to menu loads the menu level
- [ ] Death screen shown on the death event
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Player/. Pause works while walking, swimming, aiming and with a text card shown.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
