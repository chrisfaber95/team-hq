---
id: G-034
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-033]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 2
user_check: false
user_ok: false
pr: 29
---
## Goal
Replace the placeholder `ABP_Unarmed` with `ABP_Indy`, an animation Blueprint on `UIndyAnimInstance` that plays idle, walk, run, jump, fall loop and landing from the library, in both views.

## Acceptance
- [ ] `AIndyCharacter` uses `ABP_Indy`; idle, walking and running blend smoothly by speed and direction (the blend spaces from G-033), with no sliding feet.
- [ ] Jump start, fall loop and a landing play; the landing is light below the damage height and heavy from a damaging fall (the landing tier from G-023).
- [ ] The animations show the same in 1st and 3rd person and when the view is toggled mid-move (no restart).
- [ ] Animations come from the library (on the skeleton approach from G-024); no new pack. The hand-off lists each animation used.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (plus the one reference in `AIndyCharacter`).

## Notes (lead)
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (new). Leave `ABP_Unarmed` in place. The character's reference changes in `IndyCharacter.cpp` (constructor `FClassFinder`).
- Library: `Idle`, `Jump`, `FallLoop`, `LandingRoll`, plus the blend spaces.
- The blend spaces (G-033) have samples only at max speed, so the graph must handle idle and slow speeds itself (idle state, or blend from `Idle`). Later tickets add states to this graph; leave a clear place per traversal mode.
- If the graph is too much for one run, build idle/locomotion first, then jump/fall/landing, and commit between.

## Blocked
Question: can the lead supply a way to author `ABP_Indy`, or approve building it by hand in an editor? The editor MCP has no animation-graph support: `BlueprintTools.create` with `/Script/Engine.AnimBlueprint` fails ("Unable to create asset ABP_Indy"), and its tools list nothing for AnimGraph state machines, blend space or sequence player nodes. A Python commandlet can't build anim graph nodes either. No files were changed in the worktree.

## Hand-off (engineer writes, max 300 tokens)
PR #29 into epic/F-015 (commit 3a9a5fa): https://github.com/chrisfaber95/my-game-project/pull/29. The Review section held no reviewer findings, only the lead's round-0 note, so this is the first implementation under the Lead decision.
- New `ABP_Indy` = duplicate of ABP_Unarmed reparented to `UIndyAnimInstance` (idle/walk/run stay on its graph). `AIndyCharacter` FClassFinder now points at it.
- C++: `PlayMoveAnimation`/`StopMoveAnimation` (slot `DefaultSlot`), table `MoveAnimations` set in ABP_Indy defaults, pure `IndyMoveAnim::NextState` (None/Jump/Fall/LandLight/LandHeavy; traversal and roll suspend it). Private `Character` renamed `OwnerCharacter` (clashed with a BP variable).
- Animations: Jump `anim_InPlace_Jump_L`, fall loop `anim_FallLoop_01_L`, heavy landing `anim_LandRoll_R` (library); light landing `MM_Land` (project sample, the library has no light landing).
- Checks: `unreal-editor.sh check` exit 0 (CompileAllBlueprints 0 errors, 0 failed to load); automation MyGameProject.Animation 7/7 pass; reload script confirmed parent class and rows.
- Rework round 1: PR body now has the DSL of ABP_Indy's class defaults (parent IndyAnimInstance, 4 MoveAnimations rows) and states the graph is an unchanged ABP_Unarmed duplicate. No code or asset change.
- Reviewer: PIE check still needed (DefaultSlot on the full body, views, sliding feet); blend spaces unused; BP var GroundSpeed auto-renamed GroundSpeed_0 (warning). CI `check` was pending at hand-off.

## Review (reviewer writes, one line per round)
round 0 (lead, not a review): first implementation under the "Lead decision" at the bottom; no earlier work exists.
round 1: changes - PR body has no DSL text for the changed Blueprint ABP_Indy (required for every changed .uasset): add the DSL of its class defaults (parent class and the 4 MoveAnimations rows) and state the graph is an unchanged duplicate of ABP_Unarmed.
round 2: approve

## Lead decision (answer to the block)
Do not author an AnimGraph. Tooling cannot, and `ABP_Unarmed` already has a full-body Slot node (`AnimGraphNode_Slot`). New approach for this and the later animation tickets:
1. `ABP_Indy` = a duplicate of `/Game/Characters/Mannequins/Anims/Unarmed/ABP_Unarmed` saved as `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy`, reparented to `UIndyAnimInstance` (your earlier run showed this works). Its locomotion graph stays as is (Epic sample content, same skeleton; the brief allows it after the library). The G-033 blend spaces stay in the project, unused for now.
2. In C++ on `UIndyAnimInstance` add a small, Blueprint-callable player: `PlayMoveAnimation(UAnimSequenceBase*, Loop, BlendIn, BlendOut, PlayRate)` and `StopMoveAnimation(BlendOut)`, built on the default slot (`PlaySlotAnimationAsDynamicMontage`). Blends come from the montage blend times. Keep the choice of animation in a data-driven struct (mode/state -> sequence) editable in the `ABP_Indy` class defaults, not hard-coded paths.
3. This ticket wires the jump, fall loop and landing from the library (light/heavy by the landing tier) through that player when the character leaves the ground, falls and lands; the walk/run/idle stay on the duplicated graph. The ladder, wall, ledge, swing, crouch and roll tickets then only fill the same table and trigger the player on their mode change.
4. `AIndyCharacter` points at `ABP_Indy` (constructor `FClassFinder`).
Acceptance stays as written, except "idle, walking and running blend smoothly by the blend spaces from G-033" now means "by the duplicated graph". Add an automation test for any pure helper (e.g. which table row applies). If something in the duplicate or the slot turns out not to work, block again with what you found.
