---
id: G-007
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-006]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 11
---
## Goal
FOV per view and look sensitivity can be changed in-game and apply immediately.

## Acceptance
- [ ] FOV is stored separately for first and third person, and look sensitivity once; each changes in-game through console variables or exec functions (`Indy.Fov1P`, `Indy.Fov3P`, `Indy.LookSensitivity`) and applies at once, also during a glide.
- [ ] The values live in one settings object that F-013 can later persist and show in a menu.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Camera/`. No menu and no saving here (F-013). Invert Y and key rebinding are out of scope.

## Hand-off (engineer writes, max 300 tokens)
Added `UIndyViewSettings` (game instance subsystem, `Camera/IndyViewSettings.*`): Fov1P, Fov3P, LookSensitivity with clamped getters/setters, `OnSettingsChanged`, and cvars `Indy.Fov1P`, `Indy.Fov3P`, `Indy.LookSensitivity`. `AIndyCharacter::UpdateView` sets camera FOV each tick as a lerp of the two by the view blend, so changes apply at once, also mid-glide; Look/LookGamepad scale by the sensitivity. No assets, no new dependency.
PR: https://github.com/chrisfaber95/my-game-project/pull/11 (into epic/F-009).
Checks run: `unreal-editor.sh check` (build OK; CompileAllBlueprints 0 errors, 0 failed to load), clang-format 18.1.8 clean. Automation test `MyGameProject.Camera.ViewSettings.Clamp` compiled, not run. No PIE check.
Reviewer: check cvar callback/sync loop guard in `IndyViewSettings.cpp` and that cvars unregister on Deinitialize.

## Review (reviewer writes, one line per round)
round 1: approve
