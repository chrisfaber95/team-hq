---
id: G-085
kind: ticket
repo: my-game-project
base: epic/F-013
branch: team/G-085
owner: eng-my-game-project
brief: F-013
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 63
---
## Goal
Key and mouse remapping with persistence; the character rebuilds its input mapping on change.

## Acceptance
- [ ] A remapped key is used by the character immediately
- [ ] Bindings persist after restart and can reset to default
- [ ] Test covers save and load round-trip
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Player/IndyKeyBindings; own save slot. Default pause key is the engineer's call (e.g. Escape); the user checks in play.

## Hand-off (engineer writes, max 300 tokens)
PR #63 (https://github.com/chrisfaber95/my-game-project/pull/63) into epic/F-013. New `UIndyKeyBindings` subsystem (Player/): 14 remappable keyboard/mouse actions (Move split in 4), defaults = old keys, swap on conflict, ResetToDefaults, versioned own slot `KeyBindings` (Save/Load; Save is called by the later settings screen, SetKey does not auto-save), `OnBindingsChanged`. `AIndyCharacter` fills IMC_Indy from it and on change remaps + `RequestRebuildControlMappings`, so a remap applies at once. No assets changed. Checks: `unreal-editor.sh check my-game-project` exit 0 (build ok, CompileAllBlueprints 0 errors/0 failed to load); automation tests `MyGameProject.Player.KeyBindings.Swap` and `.RoundTrip` pass headless; clang-format 18.1.8 clean. Not done: PIE check of a live remap. Reviewer: look at `FillInputMapping`/`OnKeyBindingsChanged` in IndyCharacter.cpp and Load fallback logic in IndyKeyBindings.cpp. Pause key is not here (player controller ticket).

## Review (reviewer writes, one line per round)
round 1: approve
