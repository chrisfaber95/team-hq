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
review_rounds: 1
user_check: false
user_ok: false
pr: 7
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
PR #7 (https://github.com/chrisfaber95/my-game-project/pull/7), into epic/F-009. C++ only, no assets.
- New `FIndyRoll` (pure logic: refuses mid-air / running roll / zero direction, per-frame steps sum to exactly Distance). `AIndyCharacter` drives Velocity during the roll (friction and braking zeroed, restored at end), ignores Move input while rolling, cancels if the ground is lost. Direction = last move input, else actor forward (camera independent). Input: Left Alt / gamepad left face button.
- Blueprint API (`Movement|Roll`): RollDistance 400 cm, RollDuration 0.5 s, Roll(), IsRolling(), OnIndyRollStarted/Ended.
- Checks: `unreal-editor.sh check` passed (build + Blueprint compile); clang-format 18.1.8 clean.
- NOT done: automation tests `MyGameProject.Player.Roll.Distance` / `.State` compiled but not run; no PIE check. Reviewer: please run them. Also look at the roll/Move/crouch interplay and that collisions can shorten the distance.

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met by the diff; targets epic/F-009, C++ only, CI green, check named. Not verified: automation tests not run (I can't build the game project), so run them at epic review/PIE; the test arithmetic reads correct (32 frames, exact sum).
