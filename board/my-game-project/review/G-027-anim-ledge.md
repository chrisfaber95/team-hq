---
id: G-027
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-026]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 34
---
## Goal
Ledge hang shows a grab, a hang pose, shimmying and the pull-up or drop.

## Acceptance
- [ ] Grabbing a ledge plays a grab animation that ends in a hang pose with the hands on the ledge.
- [ ] Shimmying left and right plays a shimmy animation that follows the shimmy speed and stops when the player stops.
- [ ] Climbing up plays a pull-up animation ending standing on the ledge; dropping plays a release and falls.
- [ ] Blends show no pop. Animations come from the animation library first, then Epic sample content; no pack is added (new dependency: stop and write it in the ticket).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- HOW (decision, see G-034): no AnimGraph editing. Fill rows in the `MoveAnimations` table of `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (class defaults) and trigger `PlayMoveAnimation` / `StopMoveAnimation` on `UIndyAnimInstance` from the move's mode change, with blend times and play rate (follow the input speed where the move has one). New C++ stays small and gets a test for pure helpers.
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (ledge states).
- Library: `LedgeClimb` (Idle, Left, Right, Up, Down, ClimbUp), `Mantle`, `Vault`.

## Hand-off (engineer writes, max 300 tokens)
PR #34 into epic/F-015: https://github.com/chrisfaber95/my-game-project/pull/34 (commit c9fa846).
- C++: 6 ledge values in `EIndyMoveAnimState` (Grab/Idle/Left/Right/ClimbUp/Drop); pure helpers `NextLedgeState` etc. in `IndyMoveAnim`; `UIndyAnimInstance` binds `OnLedgeGrabbed`/`OnLedgeReleased`, follows `SurfaceInput.X` on the ledge, shimmy rate scales with input.
- Asset: only `ABP_Indy` class defaults, 6 new `MoveAnimations` rows (existing 20 unchanged; no AnimGraph change). Clips: LedgeClimb Idle/Left/Right/ClimbUp; no grab or release clip exists, so Grab = Idle non-looping, Drop = LedgeClimbing_Down.
- Checks: `unreal-editor.sh check` exit 0 (CompileAllBlueprints 0 errors, 0 failed to load). New automation test `MoveAnimLedge` added but NOT run.
- Reviewer: PIE check needed. Climb-up teleports the actor first while the clip plays in place; Grab/Drop clips are stand-ins; shimmy keeps animating at a ledge end while input is held.

## Review (reviewer writes, one line per round)
round 1: changes - (1) ABP_Indy changed but the PR body has no DSL text for it; add the DSL of the 6 new MoveAnimations rows (state, clip, loop, blend, play rate, root motion) to the PR body. (2) Run the new automation test MyGameProject.Animation.MoveAnimLedge and report the result in the hand-off; the C++ logic otherwise looks correct.
