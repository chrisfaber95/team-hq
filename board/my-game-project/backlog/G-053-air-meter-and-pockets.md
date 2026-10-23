---
id: G-053
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
An air meter drains underwater, refills at the surface or in air pockets, hurts at zero, and is shown in the debug HUD.

## Acceptance
- [ ] `FIndyAirMeter` drains at a tunable rate (default 5/s from 100) underwater and refills quickly (50/s) when the eye is above the surface or inside an AirPocket; automation tests cover drain, refill and clamping
- [ ] At zero air the player takes tunable damage per second (default 10/s) until they breathe or die; death uses the F-011 restart
- [ ] The debug HUD shows a line like `Air: 72 / 100`
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: `UIndyAirComponent`; the three-line IndyDebugHUD change is the meter's only display and stays in this ticket. Damage goes through `TakeDamage` (F-011 health).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
