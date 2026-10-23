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
review_rounds: 1
user_check: false
user_ok: false
pr: 66
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
New `AIndyCheckpoint` (Save/): player-only box trigger + RespawnPoint arrow; `bReached` is SaveGame, saves once to the slot via `UIndySaveSubsystem::SaveCheckpoint`. `AIndyGameMode`: `StartPlay` applies the pending restore after `Super::StartPlay`; `RestartArena`/level reload removed, death only broadcasts `OnPlayerDied` after `RestartDelay`. No assets changed.
PR: https://github.com/chrisfaber95/my-game-project/pull/66 (into epic/F-013).
Checks: `unreal-editor.sh check` exit 0 (build, CompileAllBlueprints 0 errors; one earlier run crashed only at editor restart, rerun passed); headless `MyGameProject.Save` tests 8/8 pass; clang-format 18.1.8 clean.
Reviewer: the checkpoint test covers only the non-player path (no GameInstance in a bare world); the save-on-overlap path and restore timing in a packaged build are unverified. Removing `RestartArena` would break a Blueprint that calls it (none found in C++).

## Review (reviewer writes, one line per round)
round 1: approve
