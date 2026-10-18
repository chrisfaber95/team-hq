---
id: G-011
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-008]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
Crouch and roll look like crouch and roll: the character mesh follows the shrinking capsule when crouched, and tumbles during a roll, with procedural placeholder motion (no animation assets).

## Acceptance
- [ ] When the player crouches, the mesh lowers with the capsule (feet stay on the floor) and rises again on standing; the change is smoothed over a tunable time and also works in first person (legs visible).
- [ ] During a roll the mesh does a full forward pitch tumble over the roll duration, around the capsule centre, and returns to upright when the roll ends or is cancelled.
- [ ] The motion is driven by C++ (mesh relative offset and rotation); the smoothing time and tumble on/off are Blueprint-tunable (decision 0013).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Player/`. Real crouch and roll animations (Animation Blueprint, montages) are not in F-009; this is placeholder polish only. Do not touch the mannequin assets.
- `user_check: true`: the user looks at it in the greybox map before the epic merges.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
