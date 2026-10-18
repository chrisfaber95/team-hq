---
id: G-004
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-003]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
An over-the-shoulder third-person camera that orbits freely and never shows the inside of geometry.

## Acceptance
- [ ] Third person is over-the-shoulder; mouse or right stick orbits the camera freely (pitch clamped, yaw free).
- [ ] The camera pulls in against walls, floor and ceiling and never shows their inside when the player stands or crouches against them.
- [ ] In third person the character turns to face its move direction while free-running.
- [ ] Boom length, shoulder offset and pitch limits are tunable.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Camera/`. A spring arm gives the pull-in. First person and the toggle come in G-005.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
