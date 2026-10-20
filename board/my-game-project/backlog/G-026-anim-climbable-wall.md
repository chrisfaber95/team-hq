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
user_check: true
user_ok: false
pr:
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
- Assets: `/Game/Characters/Mannequins/Anims/ABP_Indy` (wall states).
- Library: `Climbing_Animations` (Up/Down/Left/Right and diagonals, Idle, ClimbUp_At_Top, Wall_Jump_Out). Use the surface-input property from G-023 for the direction blend.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
