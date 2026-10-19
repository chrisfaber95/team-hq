---
id: G-019
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-012]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Falls hurt by height: safe below a limit, rising damage above it, lethal above a maximum.

## Acceptance
- [ ] The fall height is measured from where the player left the ground (or released a hang or swing) to where they land.
- [ ] Below the safe height no damage; above it, damage grows with height up to the lethal height, above which the fall is lethal; all three heights and the damage scale are tunable.
- [ ] Damage goes through the engine damage system (`TakeDamage`) and a Blueprint-assignable event `OnFallDamage(Damage, bLethal)` fires; the tier calculation is a pure helper with an automation test.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Player/`. There is no health yet (F-011): this only produces the damage event; do not add a health system.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
