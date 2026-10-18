---
id: G-006
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-005]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
A test aim input that sets the aim direction, with the facing rules and sidestep that follow it.

## Acceptance
- [ ] A held test input ("aim") sets an aim direction from the camera; the real aim/target system is out of scope.
- [ ] While aiming the character faces the aim direction; while free-running it faces its move direction.
- [ ] Sidestep: while aiming, move input strafes around the aim direction; when not aiming, left/right is plain lateral movement with free-run facing.
- [ ] Crouch, roll and sidestep work in both views.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Player/`. F-011 replaces the test input with the real held aim; keep the aim state in one small struct or component so it can.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
