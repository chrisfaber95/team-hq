---
id: G-010
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-001]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Blueprints can read and change the character's movement values at runtime (decision 0013), for example a lever that doubles the player's speed.

## Acceptance
- [ ] Walk speed, run speed, jump height and the two jump timers are `BlueprintReadWrite` with a `Category`, and still tunable per instance (`EditAnywhere`).
- [ ] `AddSpeedModifier(FName Source, float Multiplier)` and `RemoveSpeedModifier(FName Source)` are `BlueprintCallable`; the effective speed is the base speed times the product of all active modifiers; adding the same `Source` again replaces its multiplier. The modifier logic is a small pure helper with an automation test (two modifiers stack, removing one leaves the other, a replaced one does not double).
- [ ] The character broadcasts `BlueprintAssignable` events `OnJumped` and `OnLanded`.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Player/`, extends `AIndyCharacter` from G-001. Pattern for later tickets: every gameplay value Blueprints may tune is exposed this way.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
