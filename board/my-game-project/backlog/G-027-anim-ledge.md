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
review_rounds: 0
user_check: false
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
