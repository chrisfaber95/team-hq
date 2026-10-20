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
review_rounds: 0
user_check: false
user_ok: false
pr:
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

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
