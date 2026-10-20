---
id: G-029
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-028]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Crouch and roll play real animations and replace the placeholder motion from F-009 (ordered last of the moves).

## Acceptance
- [ ] Standing to crouch and back, crouched idle and crouched walking each play a crouch animation; the feet stay on the floor.
- [ ] Rolling plays a roll animation over the roll duration and ends in the normal standing or running pose; cancelling the roll leaves no roll pose.
- [ ] The placeholder crouch and roll motion from F-009 is removed; gameplay values (speed, duration, capsule height) do not change.
- [ ] Animations come from the animation library first, then Epic sample content; no pack is added (new dependency: stop and write it in the ticket).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (plus the removed placeholder code, named in the hand-off).

## Notes (lead)
- HOW (decision, see G-034): no AnimGraph editing. Fill rows in the `MoveAnimations` table of `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (class defaults) and trigger `PlayMoveAnimation` / `StopMoveAnimation` on `UIndyAnimInstance` from the move's mode change, with blend times and play rate (follow the input speed where the move has one). New C++ stays small and gets a test for pure helpers.
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy`.
- Library: `Crouch` (Idle and eight-way loops), `LandingRoll/anim_LandRoll_R`, `Slide`. If the roll fits poorly, use the nearest and say so in the hand-off.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
