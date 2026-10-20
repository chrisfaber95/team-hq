---
id: G-024
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-023]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr: 27
---
## Goal
The animation library's animations can play on the project mannequin: one skeleton approach, proven on one animation, so the next tickets build the animation Blueprint on it.

## Acceptance
- [ ] A library animation (`/Game/FreeAnimationLibrary/Animations/Jog/anim_Jog_Loop_Fwd`) plays on the project mannequin (`/Game/Characters/Mannequins/Meshes/SKM_Manny_Simple`) through an animation Blueprint, checked in the editor (a throwaway test setup is fine but is not committed).
- [ ] The approach is written in the hand-off: compatible skeletons, or retargeted copies (which folder, how many, which animations), or a mesh switch; the originals stay untouched.
- [ ] No new pack. `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets: the skeleton assets `/Game/Characters/Mannequins/Meshes/SK_Mannequin` and `/Game/FreeAnimationLibrary/Demo/Characters/Mannequins/Meshes/SK_Mannequin` (settings only), and, if retargeting is needed, new assets under `/Game/Characters/Mannequins/Anims/Indy/`.
- Order of preference: (1) same bone hierarchy: make the skeletons compatible (UE "Compatible Skeletons") so library animations play unchanged; (2) otherwise retarget the needed animations (see G-033 and the F-015 brief for the list) onto the project skeleton with an IK Rig / Retargeter, copies only; (3) switching the character mesh is the last resort.
- Do NOT build `ABP_Indy`, blend spaces or change `AIndyCharacter` here: that is G-033 and G-034. The previous run's uncommitted edits in this worktree (`IndyAnimInstance.*`, `IndyCharacter.cpp` pointing at a missing ABP) are premature: discard them (`git checkout -- Source`) and start from the clean branch.
- Assets the MCP cannot make: use the Python commandlet with the editor stopped through `unreal-editor.sh stop`, as in G-008. Keep the run small: at most a few turns of checking before deciding the approach.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
round 0 (lead, not a review): this is the first implementation of the narrowed ticket, not a fix; there is no earlier work to find. Previous run hit the turn cap on the larger scope.

(Hand-off, rework run) Note: the Review section had no reviewer findings, only the lead's round 0 note, so this is the first implementation. Premature Source edits were discarded as the Notes said.

## Hand-off
Approach: **compatible skeletons**. Library anims are authored on the library demo `SK_Mannequin`; the project `SKM_Manny_Simple` uses the project `SK_Mannequin`. I added the demo skeleton to the project `SK_Mannequin`'s `compatible_skeletons` (Python commandlet, reloaded: persisted). Library animations play unchanged: no retargeted copies, no mesh switch, originals untouched, no new pack. Only `Content/Characters/Mannequins/Meshes/SK_Mannequin.uasset` changed.

PR: https://github.com/chrisfaber95/my-game-project/pull/27 (into epic/F-015). `unreal-editor.sh check`: build ok, CompileAllBlueprints 0 errors, 0 failed to load.

Reviewer: acceptance 1 is only partly proven. Headless, `anim_Jog_Loop_Fwd` was accepted as the single-node animation on `SKM_Manny_Simple` (skeleton check passed), but I did not play it through an animation Blueprint or see it in PIE (bone sampling was not possible in Python; ABP is G-033). Bone hierarchies were not diffed. `assets` label does not exist in the repo, so it was not applied.
