---
id: G-025
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-034]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr: 30
---
## Goal
The ladder moves show their own animations: mounting, climbing up and down, idle on the rungs and dismounting.

## Acceptance
- [ ] Mounting at the bottom and at the top, climbing up and climbing down each play their own animation; the climb pace follows the player's movement and stops with the input.
- [ ] Dismounting at the top and at the bottom plays an animation that ends in the normal standing pose without a visible jump.
- [ ] Hands are roughly on the rungs; blends in and out of the move show no pop.
- [ ] Animations come from the animation library first, then Epic sample content; no pack is added (new dependency: stop and write it in the ticket).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- HOW (decision, see G-034): no AnimGraph editing. Fill rows in the `MoveAnimations` table of `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (class defaults) and trigger `PlayMoveAnimation` / `StopMoveAnimation` on `UIndyAnimInstance` from the move's mode change, with blend times and play rate (follow the input speed where the move has one). New C++ stays small and gets a test for pure helpers.
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (ladder states).
- Library: `Ladder` (Up, Down, Idle), `Climbing_Animations/anim_GrabWall_From_Top`, `LedgeClimb/anim_LedgeClimb_ClimbUp`. A mount or dismount with no fitting animation may reuse the nearest one; list it in the hand-off.
- Try it on the ladder of `/Game/Maps/Greybox/L_Traversal` (do not change the map).

## Hand-off (engineer writes, max 300 tokens)
PR #30 into epic/F-015: https://github.com/chrisfaber95/my-game-project/pull/30 (commit 1f89be0).
- C++: 7 ladder values in `EIndyMoveAnimState`; pure helpers in `IndyMoveAnim` (`NextLadderState` etc.); `UIndyAnimInstance` binds the ladder component's mount/dismount events, drives Idle/Up/Down from `SurfaceInput.Y`, and scales the climb play rate by |input| (stops with input).
- Asset: only `ABP_Indy` class defaults, 7 new `MoveAnimations` rows (no AnimGraph change). Library clips: Ladder Up/Down/Idle, `GrabWall_From_Top` (top mount, rate 2.5), `LedgeClimb_ClimbUp` (top dismount).
- Reused, no fitting clip: bottom mount and bottom dismount use `anim_Ladder_Idle` once.
- Checks: `unreal-editor.sh check` exit 0; CompileAllBlueprints after the asset change 0 errors, 0 failed to load; automation `MyGameProject.Animation` 8/8 pass (new `MoveAnimLadder`).
- Reviewer: PIE check still needed on the `L_Traversal` ladder (hands on rungs, blends without pop, standing pose after dismount). Dismount plays in place after the component has moved the character.

## Review (reviewer writes, one line per round)
