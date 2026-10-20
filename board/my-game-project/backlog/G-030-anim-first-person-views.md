---
id: G-030
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-029]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
In 1st person the player sees hands, arms and visible legs doing the ladder, wall, ledge and block moves, and toggling the view mid-move does not glitch any animation.

## Acceptance
- [ ] In 1st person, the ladder, climbable wall, ledge and block moves show the hands and arms (and legs where visible) consistently with the 3rd-person body.
- [ ] Toggling the camera during any of the moves in F-015 does not restart or glitch the animation.
- [ ] Animations play the same with keyboard+mouse and gamepad.
- [ ] In `/Game/Maps/Greybox/L_Traversal` every move can be done start to finish and its animation is seen without debug tools.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (map property tweaks only if needed; list them).

## Notes (lead)
- Assets: `/Game/Characters/Mannequins/Anims/ABP_Indy`, and `/Game/FirstPerson/Anims/ABP_FP_Copy` if the first-person arms need it.
- Needs every move ticket merged. The block move is G-031 (a placeholder pose is fine until it lands).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
