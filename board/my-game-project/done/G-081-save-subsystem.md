---
id: G-081
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 61
---
## Goal
Add the Save/ module: IIndySaveable interface, save object, records and UIndySaveSubsystem (single slot) with New Game, Continue, Retry and Quit to menu.

## Acceptance
- [ ] Subsystem writes and reads one slot; Continue is available only when a save exists
- [ ] New Game overwrites the slot; Retry with no checkpoint restarts the level
- [ ] Round-trip of the save object is covered by an automation test
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Module Source/.../Save/. Single Checkpoint slot overwritten each time; New Game overwrites it.

## Hand-off (engineer writes, max 300 tokens)
PR #61 (https://github.com/chrisfaber95/my-game-project/pull/61) into epic/F-013. New `Source/MyGameProject/Save/`: `IIndySaveable`, `UIndyCheckpointSave` with records, `UIndySaveSubsystem` (single slot `Checkpoint`: HasSave, NewGame, Continue, ReloadCheckpoint, QuitToMenu, SaveCheckpoint, ApplyPendingRestore, SaveGame-field capture/apply, PIE-stripped keys, version mismatch = no save). No Build.cs, uproject or asset changes.
Checks: `unreal-editor.sh check` exit 0 (build ok, 0 Blueprint errors); automation tests Save.Slot.RoundTrip, Save.Slot.VersionMismatch, Save.Key.PiePrefix pass; clang-format 18.1.8 clean.
Reviewer: NewGameMap/MenuMap are Config soft paths, unset in DefaultGame.ini (warning logged), nothing calls the subsystem yet. Capture/apply on live actors and the NewGame/ReloadCheckpoint flow have no automated test (need a game instance/world; tickets 2-3). The commit trailer says Claude Haiku 5.5, not Sonnet.

## Review (reviewer writes, one line per round)
round 1: approve
