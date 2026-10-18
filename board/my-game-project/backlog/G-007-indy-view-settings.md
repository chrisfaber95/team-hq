---
id: G-007
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-006]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
FOV per view and look sensitivity can be changed in-game and apply immediately.

## Acceptance
- [ ] FOV is stored separately for first and third person, and look sensitivity once; each changes in-game through console variables or exec functions (`Indy.Fov1P`, `Indy.Fov3P`, `Indy.LookSensitivity`) and applies at once, also during a glide.
- [ ] The values live in one settings object that F-013 can later persist and show in a menu.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Camera/`. No menu and no saving here (F-013). Invert Y and key rebinding are out of scope.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
