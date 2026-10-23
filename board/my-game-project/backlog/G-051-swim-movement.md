---
id: G-051
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-050]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Swimming is free 3D camera-relative movement with dive and surface inputs and floating at the surface, the same in 1st and 3rd person.

## Acceptance
- [ ] Forward input moves where the camera points, including up and down; swim speed is tunable (default 300, slower than run)
- [ ] Held Jump surfaces and held Crouch dives; at the surface the eye stays at or below surface + HeadAboveWater, easing rather than snapping; `OnHeadUnderwaterChanged` fires
- [ ] Facing is yaw only (aim yaw while aiming) and the capsule never pitches; roll is blocked in water; works in both views; float-clamp logic has an automation test
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: swim component + IndyCharacter in `Source/MyGameProject/Player/`. The swim component owns facing and turns off both CMC orient flags.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
