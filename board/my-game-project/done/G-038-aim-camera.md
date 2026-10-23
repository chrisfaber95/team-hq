---
id: G-038
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 40
---
## Goal
Holding aim zooms the first-person view to the sights and moves the third-person camera to a tighter over-the-shoulder view.

## Acceptance
- [ ] First person: while aiming, the FOV blends to a tunable aim FOV (relative to the player's FOV setting) and back on release.
- [ ] Third person: while aiming, the spring arm blends to a tunable shorter length and shoulder offset and back on release; the camera does not clip into walls (spring arm collision stays on).
- [ ] Blend times are tunable; toggling the view while aiming lands in the right aim pose for the new view.
- [ ] Pure blend helper with an automation test (`MyGameProject.Camera`).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Camera/` (+ the hook in `AIndyCharacter` on `OnIndyAimChanged`). Reuse `IndyViewBlend` and `IndyViewSettings` (Fov1P/Fov3P); don't change the settings API.
- The crosshair itself is G-043.
- Reviewer expects (from F-015): the new automation tests run headless (`Automation RunTests MyGameProject.<Area>`) with the result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)
PR #40 (https://github.com/chrisfaber95/my-game-project/pull/40) into epic/F-011. C++ only, no assets.
- New pure `FIndyAimBlend` (Camera/IndyAimBlend.*), independent of the view blend; `AIndyCharacter::UpdateView` applies it on top: 3P boom length/shoulder offset lerp to the aim pose, 1P FOV = Fov1P * AimFovScale. A view toggle while aiming keeps the aim pose. Spring arm collision untouched.
- Tunables (Camera|Aim, BlueprintReadWrite): AimBlendDuration, AimFovScale, AimBoomLength, AimShoulderOffset; `GetAimBlend()`. State change uses existing `OnIndyAimChanged`.
- Checks: `unreal-editor.sh check` passed (build OK, CompileAllBlueprints 0 errors, 0 failed to load). `Automation RunTests MyGameProject.Camera`: 7 tests, 6 pass incl. 3 new AimBlend tests; `ViewSettings.Clamp` fails (ensure at UObjectGlobals.cpp:3321, Package outer for a GameInstance-within class) in an untouched file, not from this change.
- Look at: UpdateView blend math; no PIE check done, values untuned. Branch lacks epic/F-011 commit 2896541 (G-036); GitHub says mergeable.

## Review (reviewer writes, one line per round)
round 1: approve
