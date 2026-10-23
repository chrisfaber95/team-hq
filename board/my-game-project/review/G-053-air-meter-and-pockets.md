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
review_rounds: 1
user_check: false
user_ok: false
pr: 56
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
Added `FIndyAirMeter` (Water/, pure: drain 5/s, refill 50/s, damage 10/s only for the time past empty), `UIndyAirComponent` on `AIndyCharacter` (breathes when the eye is in an AirPocket or outside all Water volumes; damage via `ApplyDamage`, so F-011 death/restart applies), the `Air: n / 100` line in `AIndyDebugHUD`, and `Tests/IndyAirMeterTest.cpp`. No assets, no new dependencies.
PR: https://github.com/chrisfaber95/my-game-project/pull/56 (into epic/F-014).
Checks run: clang-format 18.1.8; `unreal-editor.sh check` exit 0 (CompileAllBlueprints 0 errors, 0 failed to load); headless `MyGameProject.Water` automation 5/5 passed.
Reviewer: the death restart at zero air and the eye-based breathing rule were not exercised in a world/PIE test. Damage is applied every tick in small amounts.

## Review (reviewer writes, one line per round)
round 1: approve
