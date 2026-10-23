---
id: G-049
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-047]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
A level builder can place a water volume (water or air pocket), and pure rules decide the medium, depth and swim direction.

## Acceptance
- [ ] `AIndyWaterVolume` has a kind (Water or AirPocket), a no-collision yaw-only box whose top is the surface, and a depth from a downward floor trace (box bottom when nothing is hit)
- [ ] `FIndyWaterRules::ChooseMedium` returns Dry, Wading or Swimming from floor depth and immersion against a tunable wading depth, with swim-to-wade hysteresis; automation tests cover it
- [ ] `FIndyWaterRules::SwimDirection` is camera-relative including pitch, with dive and surface input; automation tests cover it
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Brief: `product/my-game-project/briefs/F-014-swimming-and-diving.md`.
Module: `Source/MyGameProject/Water/` (new folder); tests in `Tests/`. Depends on G-047 so `epic/F-014` is cut from main after F-011 merged.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
