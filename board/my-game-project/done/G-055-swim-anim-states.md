---
id: G-055
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-051]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 58
---
## Goal
The animation state machine has placeholder swim states, so swimming plays something.

## Acceptance
- [ ] `SwimIdle` and `Swim` are added to `EIndyMoveAnimState` and chosen from the swim medium and movement speed (automation test)
- [ ] Clip properties exist for both; with no clip assigned the graph stays visible and nothing crashes
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: `Source/MyGameProject/Animation/`; follow the pattern of G-025..G-031.

## Hand-off (engineer writes, max 300 tokens)
PR https://github.com/chrisfaber95/my-game-project/pull/58 (into epic/F-014). `SwimIdle` and `Swim` appended to `EIndyMoveAnimState`; pure `IsSwimState` and `NextSwimState(bSwimming, Speed)` in `IndyMoveAnim`; `UIndyAnimInstance` uses them when traversal is None and `UIndySwimComponent::IsSwimming()` (branch after push, before crouch/roll). Clip properties are rows in the existing `MoveAnimations` table; no row or clip stops the move animation, so the graph stays visible. Test `MyGameProject.Animation.MoveAnimSwim` added, compiled, not run. Checks run: `unreal-editor.sh check` passed (build ok, CompileAllBlueprints 0 errors, 0 failed to load); clang-format 18.1.8 clean. No assets changed. Reviewer: check the branch order in `IndyAnimInstance.cpp` and the 10 cm/s threshold using 3D speed.

## Review (reviewer writes, one line per round)
round 1: approve
