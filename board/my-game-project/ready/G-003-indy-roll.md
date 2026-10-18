---
id: G-003
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-002]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
A roll: one input moves the player a fixed distance in the current move direction (forward when standing still) and cannot start in mid-air.

## Acceptance
- [ ] One input rolls a tunable fixed distance over a tunable time, in the move direction, or forward with no move input.
- [ ] Roll cannot start in mid-air or while another roll runs.
- [ ] Roll does not depend on the camera mode and works with keyboard+mouse and gamepad.
- [ ] The distance and state rules are covered by an automation test.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Player/`. Placeholder visuals only, no animation.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
