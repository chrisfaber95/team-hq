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
review_rounds: 0
user_check: false
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
