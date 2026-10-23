---
id: G-052
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-051]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
When the camera is under the water surface the screen shows a visible tint, in both views.

## Acceptance
- [ ] A camera point inside a Water volume turns the post-process tint on; leaving turns it off
- [ ] A camera point inside an AirPocket does not tint
- [ ] Works in 1st and 3rd person
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: IndyCharacter view update in `Source/MyGameProject/Player/`. Post-process tint, no assets.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
