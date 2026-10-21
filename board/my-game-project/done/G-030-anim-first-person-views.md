---
id: G-030
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-029]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 37
---
## Goal
In 1st person the player sees hands, arms and visible legs doing the ladder, wall, ledge and block moves, and toggling the view mid-move does not glitch any animation.

## Acceptance
- [ ] In 1st person, the ladder, climbable wall, ledge and block moves show the hands and arms (and legs where visible) consistently with the 3rd-person body.
- [ ] Toggling the camera during any of the moves in F-015 does not restart or glitch the animation.
- [ ] Animations play the same with keyboard+mouse and gamepad.
- [ ] In `/Game/Maps/Greybox/L_Traversal` every move can be done start to finish and its animation is seen without debug tools.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (map property tweaks only if needed; list them).

## Notes (lead)
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy`, and `/Game/FirstPerson/Anims/ABP_FP_Copy` if the first-person arms need it.
- All move tickets are merged (G-025..G-029, G-031 block push/pull with the pack clip).
- HOW (decision, see G-034): no AnimGraph editing, also not in `ABP_FP_Copy`. If the first-person arms can only be fixed by editing an AnimGraph, stop and write it in the ticket. Prefer driving the 1st-person mesh from the same `UIndyAnimInstance` slot calls (or copy pose from the body) over new clips.
- Acceptance 4 (playing each move in `L_Traversal`) cannot be seen headless: say in the hand-off what was checked and how; the user play-tests before the epic merges.
- Reviewer expects (from G-027): the DSL text of every new or changed `MoveAnimations` row in the PR body, and the new automation test run headless (`Automation RunTests MyGameProject.Animation`) with its result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)
PR #37: https://github.com/chrisfaber95/my-game-project/pull/37 (into epic/F-015).
Cause: 1st person is the same body mesh and the same ABP_Indy; the cutaway hid the `spine_01` branch, which holds both arms and hands. Fix: `FirstPersonHiddenBone` default `spine_01` -> `neck_01` (head and neck only) in IndyCharacter.h, plus comments. No asset, AnimGraph or MoveAnimations change, so no DSL and no new test.
Toggle: it only hides/unhides a bone and never touches the anim instance or montage, so no restart. Input device never enters the anim state.
Checks: `unreal-editor.sh check` build + CompileAllBlueprints 0 errors, 0 load failures; standalone Build.bat Succeeded; headless `Automation RunTests MyGameProject.Animation` 13/13 Success, exit 0. (A Stop-hook run failed once while my own build/check ran in parallel on the same worktree; the build alone passes.)
Not checked (headless): the look of the arms and torso in 1st person, torso clipping the camera when looking down, and each move in L_Traversal. User play-test needed before the epic merges; bone is editable per instance if `neck_01` needs tuning.
Reviewer: look at the bone choice and the comments in IndyCharacter.h/.cpp.

## Review (reviewer writes, one line per round)
round 1: approve - base epic/F-015 ok, CI green, 2-file C++ change (default bone spine_01 -> neck_01) with comments; no assets, Build.cs or .uproject change; check, build and Animation tests 13/13 named in hand-off. Visual result and toggle are unverified headless: user play-test before epic merge (also confirm no BP instance overrides FirstPersonHiddenBone).
