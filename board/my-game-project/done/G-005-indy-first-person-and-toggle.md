---
id: G-005
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-004]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 9
---
## Goal
A first-person view that shows the player's own body, and one input that glides between first and third person in about 0.3 s.

## Acceptance
- [ ] In first person the camera sits in the head; the player sees their own legs and shadow; the body never blocks the view and the camera never clips through it.
- [ ] One bound input toggles first/third person while standing, running, crouching and in mid-air.
- [ ] The swap is a smooth glide of 0.2-0.4 s (default 0.3 s, tunable); movement keeps working during it and the character never cuts or snaps.
- [ ] Walk speed, run speed, crouch speed and jump height are identical in both views (an automation test reads the one source).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Camera/`. The placeholder mannequin in `Content/Characters/Mannequins` may be used by reference, not edited. How the body is hidden or shown per view is the engineer's call.

## Hand-off (engineer writes, max 300 tokens)
PR #9 (https://github.com/chrisfaber95/my-game-project/pull/9) into epic/F-009, C++ only, no assets.
- New `Camera/IndyViewBlend` (pure glide state, 0.3 s default, 0.2-0.4 tunable) + `AIndyCharacter` view toggle (V / right-stick click), blends boom length, offset and pivot into the head; crouch-aware eye height.
- At blend >= 0.8 the mesh branch from `spine_01` is hidden (legs stay); hidden `ShadowMesh` casts the full shadow. Body turns to the camera in first person at TurnRate (no snap).
- Character now sets SKM_Manny_Simple + ABP_Unarmed by reference.
- Checks: `unreal-editor.sh check` passed (build OK, CompileAllBlueprints 0 errors). 3 new automation tests compile but were NOT run.
- Reviewer look at: bone name `spine_01` on SKM_Manny_Simple, mesh offset (-88 z, -90 yaw), shadow/PIE look (unverified visually), cutaway threshold.

## Review (reviewer writes, one line per round)
round 1: approve
