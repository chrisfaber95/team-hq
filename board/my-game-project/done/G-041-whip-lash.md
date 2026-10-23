---
id: G-041
kind: ticket
repo: my-game-project
base: epic/F-011
branch: team/G-041
owner: eng-my-game-project
brief: F-011
depends_on: [G-039]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 45
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
C++ only, no assets. PR #45 (team/G-041 into epic/F-011): https://github.com/chrisfaber95/my-game-project/pull/45
- `IndyWhipSelection::PickEnemy`: pure helper, nearest enemy in reach and cone.
- `UIndyWhipComponent::TryWhip` lashes first (enemy wins over anchor): `ApplyDamage` with `UIndyWhipDamageType` (G-039 staggers), fires `OnWhipLash(Enemy)`. No enemy in reach: anchor/whiff as before. Cooldown with an enemy in reach: returns false, no anchor fallback.
- Tunables (Category `Traversal|Whip|Lash`): LashReach 300 cm, LashConeAngle 45 deg half, LashDamage 10, LashCooldown 0.6 s. Cone uses the pawn's forward vector.
Checks run: clang-format 18.1.8 OK; `unreal-editor.sh check` build + CompileAllBlueprints 0 errors; headless `Automation RunTests MyGameProject.Traversal` 13/13 pass (new WhipSelection.PickEnemy, existing Pick, WhipArc).
Reviewer: cooldown/anchor-fallback behaviour, no line-of-sight check, no PIE check done.

## Review (reviewer writes, one line per round)
round 1: approve
