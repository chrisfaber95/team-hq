---
id: G-028
kind: ticket
repo: my-game-project
base: epic/F-015
branch:
owner: eng-my-game-project
brief: F-015
depends_on: [G-027]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr: 35
---
## Goal
The whip swing shows attach, swing arc, landing at the anchor and early release; falls and landings play fitting animations.

## Acceptance
- [ ] Attaching the whip, the swing arc and the landing at the anchor each play a matching animation; releasing early plays a falling pose.
- [ ] Falling plays a falling animation; the landing animation scales with the fall tier (light below the damage height, heavy from a damaging fall), refining the jump/fall/landing rows from G-034.
- [ ] Blends show no pop. Animations come from the animation library first, then Epic sample content; no pack is added (new dependency: stop and write it in the ticket).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- HOW (decision, see G-034): no AnimGraph editing. Fill rows in the `MoveAnimations` table of `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (class defaults) and trigger `PlayMoveAnimation` / `StopMoveAnimation` on `UIndyAnimInstance` from the move's mode change, with blend times and play rate (follow the input speed where the move has one). New C++ stays small and gets a test for pure helpers.
- Assets: `/Game/Characters/Mannequins/Anims/Indy/ABP_Indy` (swing and landing states).
- Library: `Update_2/AS_Grappel_Throw`, `AS_Grappel_Jump`, `AS_Grappel_Land` (anim sequences), `FallLoop`, `LandingRoll`, `Pole`.
- Reviewer expects (from G-027): the DSL text of every new or changed `MoveAnimations` row in the PR body, and the new automation test run headless (`Automation RunTests MyGameProject.Animation`) with its result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)
Added swing states SwingAttach/SwingArc/SwingLand/SwingRelease (pure NextSwingState + IsSwingState; UIndyAnimInstance binds OnSwingStarted/OnSwingEnded) and four MoveAnimations rows in ABP_Indy (Grappel Throw/Jump/Land, FallLoop_02 as release pose); DSL of the rows is in the PR. Jump/Fall/LandLight/LandHeavy rows from G-034 already match the tier criterion, unchanged. PR: https://github.com/chrisfaber95/my-game-project/pull/35 (into epic/F-015).
Checks: unreal-editor.sh check passed (build, 0 BP errors, 0 failed to load); `Automation RunTests MyGameProject.Animation` 12/12 incl. new MoveAnimSwing; clang-format 18.1.8. Only ABP_Indy asset changed.
Look at: swing branch order in NativeUpdateAnimation; SwingRelease played at rate 4 (~0.8 s) so a landing right after release is delayed; no PIE check done; no `assets` label exists in the repo (not applied); git agent used Haiku trailer.

## Review (reviewer writes, one line per round)
