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
review_rounds: 1
user_check: false
user_ok: false
pr: https://github.com/chrisfaber95/my-game-project/pull/68
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
Added AIndyPlayerController (pause key Escape/P in its own IMC with bTriggerWhenPaused; TogglePause = SetGamePaused + UI-only input; creates HUD/start/pause/death widgets from Config soft class paths; death screen on OnPlayerDied; pause ignored when dead, on menu, or paused) and AIndyMenuGameMode. AIndyGameMode now uses the controller and drops the debug HUD. AIndyCharacter::PawnClientRestart removes only its own mapping context instead of ClearAllMappings, so the pause context survives.
PR: https://github.com/chrisfaber95/my-game-project/pull/68 (into epic/F-013).
Checks: `unreal-editor.sh check` exit 0 (build, CompileAllBlueprints 0 errors; first run hit an editor OOM on restart, rerun passed); automation test PauseRules.CanOpenPause passed; clang-format ok. No assets changed.
Reviewer: the IndyCharacter mapping change; widget class paths are unset until the WBP ticket, so no screen shows yet. A PIE check of freeze/resume/death needs the WBPs.

## Review (reviewer writes, one line per round)
round 1: approve
