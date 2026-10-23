---
id: G-048
kind: ticket
repo: my-game-project
base: main
branch:
owner: eng-my-game-project
brief:
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The automation test `MyGameProject.Camera.ViewSettings.Clamp` passes again without an engine ensure.

## Acceptance
- [ ] `Automation RunTests MyGameProject.Camera` passes all tests headless, with no ensure in the log; result in the hand-off.
- [ ] The test still checks the same clamping (FOV and sensitivity limits), and `UIndyViewSettings` behaves the same in game.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Found by G-038: the test fails with an ensure at `UObjectGlobals.cpp:3321` (Package outer for a GameInstance-within class). `Source/MyGameProject/Tests/IndyViewSettingsTest.cpp` l.11 does `NewObject<UIndyViewSettings>(GetTransientPackage())`, but `UIndyViewSettings` is a `UGameInstanceSubsystem` (`Within=GameInstance`). Give it a `UGameInstance` outer in the test (or move the clamp rules into a pure helper and test that); don't change the subsystem's base class.
- Module: `Source/MyGameProject/Tests/` (+ `Camera/IndyViewSettings` only if a pure helper is extracted). No brief: `base: main`.
