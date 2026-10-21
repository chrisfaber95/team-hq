---
id: G-029
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-028]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 36
---
## Goal
Crouch and roll play real animations and replace the placeholder motion from F-009 (ordered last of the moves).

## Acceptance
- [ ] Standing to crouch and back, crouched idle and crouched walking each play a crouch animation; the feet stay on the floor.
- [ ] Rolling plays a roll animation over the roll duration and ends in the normal standing or running pose; cancelling the roll leaves no roll pose.
- [ ] The placeholder crouch and roll motion from F-009 is removed; gameplay values (speed, duration, capsule height) do not change.
- [ ] Animations come from the animation library first, then Epic sample content; no pack is added (new dependency: stop and write it in the ticket).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (plus the removed placeholder code, named in the hand-off).

## Notes (lead)
- HOW (decision, see G-034): no AnimGraph editing. Fill rows in the `MoveAnimations` table of `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (class defaults) and trigger `PlayMoveAnimation` / `StopMoveAnimation` on `UIndyAnimInstance` from the move's mode change, with blend times and play rate (follow the input speed where the move has one). New C++ stays small and gets a test for pure helpers.
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy`.
- Library: `Crouch` (Idle and eight-way loops), `LandingRoll/anim_LandRoll_R`, `Slide`. If the roll fits poorly, use the nearest and say so in the hand-off.
- Also in the project since G-035 (not a new pack): `/Game/FreeSampleAnimationSet/Animations/DashDodgeRollSet/Mannequin/RootMotion/Roll/A_Roll_IdleFwd` (baked root motion: use the `bIgnoreRootMotion` row flag from G-031 so the roll distance stays the gameplay value).
- Reviewer expects (from G-027): the DSL text of every new or changed `MoveAnimations` row in the PR body, and the new automation test run headless (`Automation RunTests MyGameProject.Animation`) with its result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)

PR #36 (https://github.com/chrisfaber95/my-game-project/pull/36) into epic/F-015. New states CrouchIdle, CrouchWalk, Roll in `UIndyAnimInstance`; pure helpers + test `MyGameProject.Animation.MoveAnimCrouchRoll`. Three new `MoveAnimations` rows in ABP_Indy (only asset changed; DSL in PR body): Crouch idle, Crouch_Fwd_Loop (rate follows speed/CrouchSpeed), A_Roll_IdleFwd (root motion ignored, rate fitted to RollDuration). No gameplay values changed. F-009 left no placeholder motion in Source, so nothing was removed.
Checks: `unreal-editor.sh check` passed (build, CompileAllBlueprints 0 errors); headless `Automation RunTests MyGameProject.Animation` 13/13 pass; reload run shows 32 rows.
Reviewer: PIE not done (headless): check feet on the floor when crouching, roll pose ending cleanly. Only the forward crouch loop is used (no eight-way); no stand/crouch transition clips. PR has no `assets` label (repo has none).


## Review (reviewer writes, one line per round)
round 1: changes - 1) IndyMoveAnimTest.cpp: the new FIndyMoveAnimCrouchRollTest is after the closing `#endif // WITH_DEV_AUTOMATION_TESTS` (line 191); move it inside the guard, or builds without dev automation tests fail to compile (class undefined). Rest meets the criteria (row DSL in PR body, asset listed, check run, base epic/F-015).
