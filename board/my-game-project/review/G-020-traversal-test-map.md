---
id: G-020
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-019]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 2
user_check: true
user_ok: false
pr: 24
---
## Goal
A test map with one example each of ladder, climbable wall, ledge, block and whip anchor in a row, passable without debug tools.

## Acceptance
- [ ] In one row: a ladder, a climbable wall, a ledge route, a pushable block puzzle and a whip anchor over a 6 m+ gap; each uses its marked volume with a visible cue.
- [ ] A player can pass the row start to end in both views, using only normal input.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (plus the push-grab C++ fix, see Notes).

## Notes (lead)
- Assets: `/Game/Maps/Greybox/L_Traversal` (new, same method as G-008: the Python commandlet, with the editor stopped through `unreal-editor.sh stop`). Place the volumes and block actors by class.
- Do not edit `L_Greybox`; this is a separate map.

- User play-test, round 1 (user_ok NOT given): standing against any side of the push block and pressing E, the character mesh clips into the block, and the block does not move at all. Lead diagnosis: `UIndyPushComponent::TryGrab` (Source/MyGameProject/Traversal/IndyPushComponent.cpp ~l.77) sets `HoldDistance = Max(dot(Approach, PushDirection), Radius)`, the distance to the block CENTRE, then teleports the character to centre minus HoldDistance: when the character stands at the block face that is only half the block width, so the capsule (radius ~34) ends up inside the block. Fix: place the character at the block face on the push axis plus the capsule radius plus a small gap, i.e. HoldDistance = block half-extent along PushDirection + Radius + gap (tunable, exposed). Make the placement a pure helper in IndyPushAxis with an automation test. Run the test and report the result. Then confirm the block then moves when pushed and pulled (it must still stop at walls and other blocks); the map block may also need fixing (scale, pivot, which way it faces the 180 wall): check it. Scope exception for this rework: C++ in IndyPushComponent/IndyPushAxis may change besides L_Traversal; the acceptance line about assets still holds (only L_Traversal).

## Hand-off (engineer writes, max 300 tokens)
Round 1: added `/Game/Maps/Greybox/L_Traversal` (only asset; L_Greybox untouched). PR: https://github.com/chrisfaber95/my-game-project/pull/24 (base epic/F-010, not merged).

Rework (user play-test: character clipped into the push block, block did not move), commit ddfe9c2. Cause: the map's SM_Cube pivot is at its min corner, and `UIndyPushComponent::TryGrab` took the approach direction and standing point from the actor origin (the corner) and used the distance to it as hold distance, so the capsule ended inside the block on a wrong axis. Fix: pure helpers `IndyPushAxis::HalfExtentAlong` and `HoldDistance` (face + capsule radius + gap); TryGrab uses the mesh bounds centre; new `HoldGap` property (4 cm); automation test `PushAxis.HoldDistance`. L_Traversal unchanged (block 160x280x100, wall 180 are fine).

Checks: `unreal-editor.sh check` exit 0 (incl. CompileAllBlueprints 0 errors), headless automation `MyGameProject.Traversal`: 9 passed, 0 failed; clang-format 18.1.8 clean; CI `check` green. Not played: push, pull and stopping at the wall or other blocks are reasoned, not tried in PIE, so the user's PIE check in both views (user_check) is still needed. Reviewer: look at TryGrab in IndyPushComponent.cpp.

## Review (reviewer writes, one line per round)
round 1: approve - base epic/F-010, only L_Traversal.umap changed (matches Assets), no BP/C++ change, check ran and CI green. Passability (ledge 270 vs jump 120, block+wall, whip range) is reasoned, not played: user PIE check in both views is required.
round 2: approve - rework fixes TryGrab: holds at mesh bounds centre, HoldDistance = face + radius + gap via tested pure helpers, HoldGap exposed; only L_Traversal.umap asset, check + 9 automation tests passed, CI green. Push/pull/wall stop not played: user PIE check in both views still required (user_ok).
