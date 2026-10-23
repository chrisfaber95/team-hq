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
review_rounds: 1
user_check: false
user_ok: false
pr: https://github.com/chrisfaber95/my-game-project/pull/67
---
## Goal
C++ widget bases for start, pause, death and settings screens.

## Acceptance
- [x] Start: New Game, Continue (only with save), Settings, Quit
- [x] Pause: Resume, Restart from checkpoint, Settings, Quit to menu; Death: Retry, Quit to menu
- [x] Settings widget exposes view, FOV, sensitivity and remapping, reachable from start and pause
- [x] `unreal-editor.sh check` passes (build and Blueprint compile)
- [x] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. UI/ module; layout-only WBPs come in G-089. No confirmation dialogs. Keyboard and mouse navigation.

## Hand-off (engineer writes, max 300 tokens)
Added UI/ widget bases: IndyMenuWidget (base), IndyStartWidget, IndyPauseWidget, IndyDeathWidget, IndySettingsWidget, IndyKeyBindingRowWidget, plus Tests/IndyMenuWidgetTest.cpp. No assets, no new deps. PR: https://github.com/chrisfaber95/my-game-project/pull/67 (into epic/F-013).
Checks: unreal-editor.sh check exit 0 (build ok; CompileAllBlueprints 0 errors, 0 failed to load); clang-format 18.1.8 clean. New automation tests compiled, not run. No PIE check (no WBPs yet).
Reviewer: settings screen is spawned from SettingsWidgetClass/KeyRowClass (set in G-089 WBPs); pause/death widgets call the save subsystem directly; pause widget unpauses and resets input mode itself (ticket 8's controller owns creation and the pause key).

## Review (reviewer writes, one line per round)
round 1: approve
