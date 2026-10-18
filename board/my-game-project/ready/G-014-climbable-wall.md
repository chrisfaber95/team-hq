---
id: G-014
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-013]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The player climbs marked walls in four directions and tops out onto the platform above.

## Acceptance
- [ ] A marked wall can be grabbed by moving into it; move input goes up, down, left and right along the wall, staying on the wall surface and inside the marked area.
- [ ] Leaving the marked area at the top ends in standing on top.
- [ ] An unmarked wall cannot be grabbed; the player can let go at any time.
- [ ] Works in first and third person, with keyboard+mouse and gamepad; the view toggle works during the move without dropping it.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. Sticking to the wall: trace to the surface inside the volume, no animation needed.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
