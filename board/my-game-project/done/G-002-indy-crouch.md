---
id: G-002
kind: ticket
repo: my-game-project
base: epic/F-009
branch: team/G-002
owner: eng-my-game-project
brief: F-009
depends_on: [G-010]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: https://github.com/chrisfaber95/my-game-project/pull/6
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

PR #6 (https://github.com/chrisfaber95/my-game-project/pull/6, into epic/F-009), C++ only in `IndyCharacter.h/.cpp`, no assets. IA_Crouch built in code (Left Ctrl / gamepad East); `bToggleCrouch` (hold vs toggle), `CrouchSpeed` (-> MaxWalkSpeedCrouched, incl. speed modifiers), `OnIndyCrouchChanged(bool)` BlueprintAssignable, all with Category. Ceiling check is ACharacter/CMC's own: stand-up stays pending under a low ceiling and completes when free; no custom trace.
Checks: `unreal-editor.sh check` passed (build OK, CompileAllBlueprints 0 errors, 0 failed to load); clang-format 18.1.8 clean. No automated tests.
NOT met: criterion 3 (low-ceiling gap) has no automation test and no PIE run (headless). PR lists the PIE steps; needs a manual check in a level with a low gap. Reviewer: toggle path in CrouchPressed, and whether criterion 3 may pass on the documented PIE steps.

## Review (reviewer writes, one line per round)
round 1: approve - C++ only, no assets, base epic/F-009, CI green, check named. Toggle path is correct (bWantsToCrouch -> UnCrouch, else Crouch). Criterion 3 is met as written ("documented PIE check in the PR"), but the PIE run itself is still undone; a manual check in a low-gap level is advisable before the epic.
