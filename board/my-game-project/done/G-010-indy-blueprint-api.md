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
review_rounds: 1
user_check: false
user_ok: false
pr: 5
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
PR #5 (https://github.com/chrisfaber95/my-game-project/pull/5, into epic/F-009). C++ only, no assets.
- Walk/Run speed, JumpHeight, CoyoteTime, JumpBufferTime now EditAnywhere + BlueprintReadWrite.
- `AddSpeedModifier`/`RemoveSpeedModifier` (BlueprintCallable) on AIndyCharacter; logic in pure `FIndySpeedModifiers` (product of modifiers, same Source replaces, negative clamps to 0). Settings are re-applied on modifier change and before each jump so runtime edits take effect.
- Events are named `OnIndyJumped` / `OnIndyLanded`, not `OnJumped`/`OnLanded`: ACharacter already has an `OnJumped` function, so the exact name would not compile. Reviewer: confirm this is acceptable.
- Checks run: `unreal-editor.sh check` passed (build + all Blueprints compile, 0 errors); automation tests MyGameProject.Player (SpeedModifiers, JumpTimer.Buffer, JumpTimer.Coyote) all passed; clang-format 18.1.8 applied. No PIE check.

## Review (reviewer writes, one line per round)
round 1: approve
