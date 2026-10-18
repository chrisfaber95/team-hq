---
id: G-016
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-015]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr: 20
---
## Goal
The player pushes and pulls blocks along one straight axis.

## Acceptance
- [ ] `AIndyPushBlock` (Source/MyGameProject/Traversal/) can be pushed or pulled while the player holds the input, sliding continuously along one axis (the axis nearest the player's approach), at a tunable speed.
- [ ] The block stops at walls and other blocks, and the player stays attached to it while moving.
- [ ] Releasing the input stops the block; the player can let go and walk away.
- [ ] Event `OnBlockMoved` / `OnBlockStopped` are Blueprint-assignable so puzzles can react (a pressure plate, a gate).
- [ ] Works in first and third person, with keyboard+mouse and gamepad; the view toggle works during the move without dropping it.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. Blocks cannot crush the player (out of scope). F-014 reuses this under water; keep the move code free of ground-only assumptions.

## Hand-off (engineer writes, max 300 tokens)
Added `AIndyPushBlock` (slides by sweep, stops at walls/blocks; `PushSpeed`, `GrabRange`; `OnBlockMoved`/`OnBlockStopped`), `UIndyPushComponent` on the character (Interact grabs the nearest block, held move input along the block axis nearest the approach side pushes or pulls, player stays attached; releasing input stops the block; Interact/jump/crouch/roll lets go), pure `IndyPushAxis` helpers with automation tests, and a new `EIndyTraversalMode::Push`. C++ only, no assets. PR: https://github.com/chrisfaber95/my-game-project/pull/20
Checks: `unreal-editor.sh check` exit 0 (build ok; CompileAllBlueprints 0 errors, 0 failed to load); clang-format 18.1.8. The new automation tests were not run and there was no PIE test.
Reviewer: check the pull case (character leads, block follows) in `IndyPushComponent.cpp` TickComponent, and the Interact routing in `IndyCharacter.cpp`.


## Review (reviewer writes, one line per round)
