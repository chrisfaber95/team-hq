---
id: G-026
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-025]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr: 31
---
## Goal
The climbable wall shows climbing in all four directions, an idle hang and a top-out.

## Acceptance
- [ ] Climbing up, down, left and right each play a matching animation; holding still on the wall shows a hanging/idle pose.
- [ ] Topping out at the end of the marked area plays a pull-up animation that ends standing on top, without a jump in position.
- [ ] Blends in and out show no pop; hands roughly on the wall.
- [ ] Animations come from the animation library first, then Epic sample content; no pack is added (new dependency: stop and write it in the ticket).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- HOW (decision, see G-034): no AnimGraph editing. Fill rows in the `MoveAnimations` table of `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (class defaults) and trigger `PlayMoveAnimation` / `StopMoveAnimation` on `UIndyAnimInstance` from the move's mode change, with blend times and play rate (follow the input speed where the move has one). New C++ stays small and gets a test for pure helpers.
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (wall states).
- Library: `Climbing_Animations` (Up/Down/Left/Right and diagonals, Idle, ClimbUp_At_Top, Wall_Jump_Out). Use the surface-input property from G-023 for the direction blend.

## Hand-off (engineer writes, max 300 tokens)
PR #31 into epic/F-015: https://github.com/chrisfaber95/my-game-project/pull/31 (commit a0c8c62).
- C++: 6 wall values in `EIndyMoveAnimState` (Idle/Up/Down/Left/Right/TopOut); pure helpers in `IndyMoveAnim` (`NextWallState` etc.); `UIndyAnimInstance` follows `SurfaceInput` in Wall mode (stronger axis wins), binds `OnWallReleased` and asks for TopOut on `Top`; climb rate scales with input.
- Asset: only `ABP_Indy` class defaults, 6 new `MoveAnimations` rows (no AnimGraph change, so no graph DSL). Clips: Climbing_Animations Climb_Idle/Up/Down/Left/Right, `ClimbUp_At_Top` (top-out). Diagonals use the dominant axis; no wall grab clip.
- Checks: `unreal-editor.sh check` exit 0 (CompileAllBlueprints 0 errors, 0 failed to load); automation `MyGameProject.Animation` 9/9 pass (new `MoveAnimWall`).
- Reviewer: PIE check still needed on the L_Traversal climb wall (hands on wall, no pops, top-out lands on top). Top-out plays in place after the component already moved the character up. PR label `assets` does not exist in the repo.

## Review (reviewer writes, one line per round)
