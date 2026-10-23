---
id: G-049
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-047]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 52
---
## Goal
A level builder can place a water volume (water or air pocket), and pure rules decide the medium, depth and swim direction.

## Acceptance
- [ ] `AIndyWaterVolume` has a kind (Water or AirPocket), a no-collision yaw-only box whose top is the surface, and a depth from a downward floor trace (box bottom when nothing is hit)
- [ ] `FIndyWaterRules::ChooseMedium` returns Dry, Wading or Swimming from floor depth and immersion against a tunable wading depth, with swim-to-wade hysteresis; automation tests cover it
- [ ] `FIndyWaterRules::SwimDirection` is camera-relative including pitch, with dive and surface input; automation tests cover it
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Brief: `product/my-game-project/briefs/F-014-swimming-and-diving.md`.
Module: `Source/MyGameProject/Water/` (new folder); tests in `Tests/`. Depends on G-047 so `epic/F-014` is cut from main after F-011 merged.

## Hand-off (engineer writes, max 300 tokens)
Added `Source/MyGameProject/Water/`: `AIndyWaterVolume` (Water/AirPocket, no-collision yaw-only box, top = surface, depth from a down floor trace, box bottom if no hit), `FIndyWaterRules` (`ChooseMedium` with hysteresis, `FloorDepth`, `SwimDirection`), enums. Tests in `Tests/IndyWaterRulesTest.cpp`.
PR: https://github.com/chrisfaber95/my-game-project/pull/52 (into epic/F-014, not merged).
Checks run: `unreal-editor.sh check` exit 0 (build ok; CompileAllBlueprints 0 errors, 0 failed to load); clang-format 18.1.8 applied.
**Not run:** the automation tests `MyGameProject.Water.*` were compiled but not executed: a worktree editor started by another session was running and I was not allowed to stop it. Reviewer: run `Automation RunTests MyGameProject.Water` with no editor on the worktree.
Look at: the hysteresis rule in `ChooseMedium` (threshold applies to both floor depth and immersion); the `SwimDirection` axis convention (Move.Y forward, Move.X right; check against the character's input); git CRLF warnings on the new files.

## Review (reviewer writes, one line per round)
round 1: approve (automation tests not executed, I may not open the editor; I traced every test case against the code by hand and all hold. Recommend running `MyGameProject.Water` once before the epic PR.)
