---
id: G-004
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-003]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 8
---
## Goal
An over-the-shoulder third-person camera that orbits freely and never shows the inside of geometry.

## Acceptance
- [ ] Third person is over-the-shoulder; mouse or right stick orbits the camera freely (pitch clamped, yaw free).
- [ ] The camera pulls in against walls, floor and ceiling and never shows their inside when the player stands or crouches against them.
- [ ] In third person the character turns to face its move direction while free-running.
- [ ] Boom length, shoulder offset and pitch limits are tunable.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Camera/`. A spring arm gives the pull-in. First person and the toggle come in G-005.

## Hand-off (engineer writes, max 300 tokens)
PR #8 https://github.com/chrisfaber95/my-game-project/pull/8 (base epic/F-009). C++ only, no assets, no new dependency.
`AIndyCharacter` now has a `USpringArmComponent` boom (collision probe on Camera channel, size 16) with the camera on its socket; the character turns to its move direction (`bOrientRotationToMovement`), Move uses the control-rotation yaw, pitch is clamped via PlayerCameraManager, yaw is free. Tunables in Category "Camera": BoomLength, ShoulderOffset, MinCameraPitch, MaxCameraPitch, TurnRate (re-applied each Tick). No delegates added.
Checks: `unreal-editor.sh check` exit 0 (CompileAllBlueprints: 0 errors, 0 failed to load); clang-format 18.1.8 clean. No PIE run.
Reviewer: check pull-in against walls/floor/ceiling relies on level geometry blocking the Camera channel; shoulder offset is included in the probe; CI `check` was pending when the PR opened.

## Review (reviewer writes, one line per round)
round 1: approve
