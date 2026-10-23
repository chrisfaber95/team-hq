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
review_rounds: 1
user_check: false
user_ok: false
pr: 50
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

## Hand-off
Test-only fix in `Source/MyGameProject/Tests/IndyViewSettingsTest.cpp`: the Clamp test now creates a `UGameInstance` and uses it as outer for `UIndyViewSettings` (Within=GameInstance), removing the ensure. Assertions and the subsystem are unchanged; no assets changed.
PR: https://github.com/chrisfaber95/my-game-project/pull/50
Checks: `unreal-editor.sh check` exit 0 (build + CompileAllBlueprints 0 errors; first run's editor restart failed on a paging-file error, second run clean); headless `Automation RunTests MyGameProject.Camera`: 4/4 pass, no ensure; clang-format 18.1.8 applied.
Reviewer: confirm the outer setup matches the original test intent. Commit trailer says Haiku 5.5, not Sonnet 5.5 (cosmetic).

## Review
round 1: approve
