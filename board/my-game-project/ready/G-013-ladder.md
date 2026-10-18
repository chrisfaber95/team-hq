---
id: G-013
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
The player mounts, climbs and dismounts marked ladders.

## Acceptance
- [ ] Interacting facing a ladder volume mounts it; while on it, move input goes up/down only, at a tunable speed.
- [ ] Reaching the top dismounts onto the platform, reaching the bottom steps off to the floor; jump drops the player off.
- [ ] A ladder-shaped object without a ladder volume cannot be mounted.
- [ ] Works in first and third person, with keyboard+mouse and gamepad; the view toggle works during the move without dropping it.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. Uses the mode component (G-012) and volumes (G-011). Top and bottom exits are derived from the volume's box ends.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
