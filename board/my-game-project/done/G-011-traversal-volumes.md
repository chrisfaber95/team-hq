---
id: G-011
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 15
---
## Goal
Level builders can place marked traversal volumes (ladder, climbable wall, ledge, whip anchor) that show a visible cue; unmarked geometry is never climbable or grabbable.

## Acceptance
- [ ] `AIndyTraversalVolume` (Source/MyGameProject/Traversal/) is a placeable actor with a box volume, a `EIndyTraversalKind` (Ladder, ClimbWall, Ledge, WhipAnchor) and a visible cue (debug-style mesh or lines, shown in game, tunable colour per kind).
- [ ] The character can ask which volumes of a kind overlap it or lie within a given range, through one query function (pure geometry helper with an automation test).
- [ ] A wall or edge with no volume is never reported by the query.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. Later tickets (ladder, wall, ledge, anchor) use this query; keep it small. Landing point of an anchor is a `FVector` property or a child scene component, the engineer's choice.
- Blueprints will place and resize these volumes in maps, so every setting is `EditAnywhere`.

## Hand-off (engineer writes, max 300 tokens)
C++ only, no assets. New `Source/MyGameProject/Traversal/`: `EIndyTraversalKind`, pure helper `IndyTraversalQuery` (`DistanceToBox`, `FindBoxes`), and placeable `AIndyTraversalVolume` (box, EditAnywhere kind, per-kind cue colour map, `bShowCue`, `LandingPoint` for anchors, `OnActorEntered/Left`, `UpdateCue`). The one query is `AIndyTraversalVolume::FindVolumes(World, Kind, Location, Range)` (Range 0 = overlap); only placed volumes are found. Tests: `Tests/IndyTraversalQueryTest.cpp`.
PR: https://github.com/chrisfaber95/my-game-project/pull/15 (into epic/F-010).
Checks: `unreal-editor.sh check` exit 0 (its log held no build output, so the exit code is the evidence); clang-format 18.1.8 applied. The automation tests were written but NOT run; no PIE check.
Reviewer: run the two automation tests; the cue is the box wireframe (non-shipping only); `FindVolumes` iterates all volumes per call. The PR title uses the ticket-id format, not `feat(source):`.

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met, C++ only, no assets, base epic/F-010; test expectations checked by hand (automation tests not run by anyone; CI does not compile).
