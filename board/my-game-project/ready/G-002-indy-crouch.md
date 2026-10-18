---
id: G-002
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-010]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The character crouches (held or toggled by one input) and can only pass under a low ceiling while crouched.

## Acceptance
- [ ] One input crouches; a setting chooses hold or toggle; crouch speed is a tunable value.
- [ ] While crouched the player cannot stand up when the space above is too low, and stands up once it is free.
- [ ] A low-ceiling gap is passable only crouched (automation test, or a documented PIE check in the PR).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Player/`, extends `AIndyCharacter`. `ACharacter::Crouch` and its uncrouch ceiling check already exist; reuse them.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
