---
id: G-025
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-024]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
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
- Assets: `/Game/Characters/Mannequins/Anims/ABP_Indy` (ladder states).
- Library: `Ladder` (Up, Down, Idle), `Climbing_Animations/anim_GrabWall_From_Top`, `LedgeClimb/anim_LedgeClimb_ClimbUp`. A mount or dismount with no fitting animation may reuse the nearest one; list it in the hand-off.
- Try it on the ladder of `/Game/Maps/Greybox/L_Traversal` (do not change the map).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
