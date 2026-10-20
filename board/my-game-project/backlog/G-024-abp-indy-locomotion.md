---
id: G-024
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-023]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Replace the placeholder `ABP_Unarmed` with `ABP_Indy`, an animation Blueprint on `UIndyAnimInstance` that plays idle, walk, run, jump, fall loop and landing from the animation library, in both views.

## Acceptance
- [ ] `AIndyCharacter` uses `ABP_Indy`; idle, walking and running blend smoothly by speed and direction, with no sliding feet.
- [ ] Jump start, fall loop and a landing play; the landing is light below the damage height and heavy from a damaging fall (the landing tier from G-023).
- [ ] The animations show the same in 1st and 3rd person and when the view is toggled mid-move (no restart).
- [ ] Animations come from the Voxel Vision Free Animation Library (`/Game/FreeAnimationLibrary/Animations/`), then Epic sample content; no pack is added (that would be a new dependency: stop and write it in the ticket). The hand-off lists each animation used and its source.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets: `/Game/Characters/Mannequins/Anims/ABP_Indy` (new); the character's animation default (the C++ constructor reference or a Blueprint child, keep decision 0013). Leave `ABP_Unarmed` in place.
- First check the library skeleton against the project mannequin (`/Game/Characters/Mannequins/Meshes/SK_Mannequin` vs `/Game/FreeAnimationLibrary/Demo/Characters/Mannequins/Meshes/SK_Mannequin`); if they differ, retarget inside the project (no new pack).
- Library folders: `Idle`, `Walk`, `Jog`, `Jump`, `FallLoop`, `LandingRoll`. Later tickets add states to this graph; leave a clear place per traversal mode.
- Blueprint logic: `user_check: true` (decision 0010).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
