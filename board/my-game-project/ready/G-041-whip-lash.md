---
id: G-041
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: [G-039]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The whip lashes an enemy within 3 m in front of the player, staggering it and doing small damage, with no ammo.

## Acceptance
- [ ] Pressing whip while not aiming, with an enemy within a tunable reach (default 3 m) in a tunable cone in front of the player (either view), lashes it: whip damage type, small tunable damage, the enemy staggers (G-039). Repeated lashes can kill it.
- [ ] An enemy in reach wins over a whip anchor; with no enemy in reach the anchor targeting (G-017) and the whiff behave as before.
- [ ] A tunable cooldown between lashes; `OnWhipLash(Enemy)` fires on a hit.
- [ ] Pure target-pick helper with an automation test, and the existing whip tests still pass.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/IndyWhipComponent` (G-017 kept the input action reusable for this). Lead choice: enemy over anchor, since anchors sit over gaps where enemies rarely stand.
- Reviewer expects (from F-015): the new automation tests run headless (`Automation RunTests MyGameProject.<Area>`) with the result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
