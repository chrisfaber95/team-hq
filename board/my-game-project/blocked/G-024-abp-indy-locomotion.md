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
budget_usd: 5
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
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (new, folder widened, see Lead decision); the character's animation default (the C++ constructor reference or a Blueprint child, keep decision 0013). Leave `ABP_Unarmed` in place.
- First check the library skeleton against the project mannequin (`/Game/Characters/Mannequins/Meshes/SK_Mannequin` vs `/Game/FreeAnimationLibrary/Demo/Characters/Mannequins/Meshes/SK_Mannequin`); if they differ, retarget inside the project (no new pack).
- Library folders: `Idle`, `Walk`, `Jog`, `Jump`, `FallLoop`, `LandingRoll`. Later tickets add states to this graph; leave a clear place per traversal mode.
- Blueprint logic: `user_check: true` (decision 0010).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
round 0 (lead, not a review): this run is the first implementation, not a fix. Do the whole ticket now following "Lead decision" at the bottom; there is no earlier work to find. Budget raised to 5.

## Blocked
Needs assets outside "Assets:". The library animations use skeleton `/Game/FreeAnimationLibrary/Demo/Characters/Mannequins/Meshes/SK_Mannequin`, not the project mannequin's, so `ABP_Indy` cannot play them as they are. Fixing that needs new assets:
1. Retargeted copies of the animations (idle, walk x6, jog x6, jump, fall loop x2, landing roll) on the project skeleton, or switching `ABP_Indy` and the character mesh to the library skeleton (more than this ticket allows).
2. Blend spaces for walk/jog by speed and direction (e.g. `/Game/Characters/Mannequins/Anims/BS_Indy_Locomotion`). The MCP toolset can't create them, so a Python commandlet is needed.
Question: may I add the retargeted animations and blend space assets? Or do you want to pick another skeleton approach?
Tried: duplicating `ABP_Unarmed` to `ABP_Indy` and reparenting to `UIndyAnimInstance` worked, but I deleted it again; nothing changed on disk (`git status` clean).

## Lead decision (answer to the block)
Scope widened: you may add assets under `/Game/Characters/Mannequins/Anims/Indy/` (retargeted animations, blend spaces, `ABP_Indy`) and change the project/library skeleton assets; no new pack, so no dependency. List every asset in the hand-off.
Order of preference: (1) if the two mannequin skeletons have the same bone hierarchy, make the project skeleton and the library skeleton compatible (UE "Compatible Skeletons") so the library animations play unchanged; (2) otherwise retarget the animations you need onto the project skeleton with an IK Rig/Retargeter (copies, originals untouched); (3) switching the character mesh to the library mannequin is the last resort. Blend spaces and other assets the MCP cannot make: use the Python commandlet with the editor stopped through `unreal-editor.sh stop`, as in G-008. `ABP_Unarmed` stays as is.
