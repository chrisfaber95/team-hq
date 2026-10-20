---
id: G-023
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
A C++ `UIndyAnimInstance` that exposes the character's movement and traversal state to animation Blueprints, so the later animation tickets only build graphs.

## Acceptance
- [ ] Read-only, Blueprint-visible properties updated each frame: ground speed, move direction relative to facing, falling, crouching, rolling, aiming, traversal mode, the move input along the surface while climbing or hanging (normalised, x right / y up), whether the held block is moving and whether it is pushed or pulled, whip swing phase, and the last landing tier (light / heavy, from the existing fall-damage tier).
- [ ] The derived values (move direction, push-or-pull sign, landing tier) are pure helpers with automation tests.
- [ ] Every property has a `Category` and is `BlueprintReadOnly`, per decision 0013. No gameplay behaviour changes.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: new folder `Source/MyGameProject/Animation/`. Read state from `AIndyCharacter`, `UIndyTraversalComponent`, `UIndyPushComponent`, `UIndySwingComponent`, `FIndyFallDamage`. A small public getter on those classes is fine; do not change their behaviour.
- Brief: `product/my-game-project/briefs/F-015-traversal-animations.md`.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
