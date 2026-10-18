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
review_rounds: 1
user_check: false
user_ok: false
pr: 10
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
Added a held test aim input (RMB / left trigger) -> `SetAiming`, with `IsAiming`, `GetAimDirection`, `OnIndyAimChanged` (Category Movement|Aim). Aim state is the small pure struct `FIndyAim` (Player/IndyAim.*) so F-011 can drive it. Aiming faces the camera aim direction and strafes around it; otherwise the character faces its move direction. C++ only, no assets.
PR: https://github.com/chrisfaber95/my-game-project/pull/10 (into epic/F-009).
Checks run: `unreal-editor.sh check` OK, Build.bat Succeeded, CompileAllBlueprints 0 errors, automation tests MyGameProject.Player.Aim.State/.Direction pass, clang-format 18.1.8.
Reviewer: behaviour change vs G-005 - first person no longer always faces the camera; facing now depends only on aim in both views (ticket rule). No PIE check done, so facing/strafe feel in both views is unverified. CI check was still pending at hand-off.

## Review (reviewer writes, one line per round)
round 1: approve
