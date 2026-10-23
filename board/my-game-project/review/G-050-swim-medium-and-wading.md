---
id: G-050
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-049]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 53
---
## Goal
The player wades slower in shallow water and switches to swimming (flying movement) in deep water and back, with no button.

## Acceptance
- [ ] Wading applies a tunable speed factor (default 0.6) and jumping still works
- [ ] Entering deep water sets Swimming (MOVE_Flying) without input; leaving returns to Wading or ground; `OnMediumChanged` fires
- [ ] The component acts only while no traversal mode is active; wading depth and speed factor are EditAnywhere
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: `UIndySwimComponent` + character wiring in `Source/MyGameProject/Player/`.
Touches IndyCharacter.cpp, as do G-051, G-052 and G-054: they run one after another.

## Hand-off (engineer writes, max 300 tokens)
Added `UIndySwimComponent` (Player/) as `Swim` on `AIndyCharacter`. With no traversal mode active it picks the medium each tick via `FIndyWaterRules::ChooseMedium`: Wading adds speed modifier "Wading" (0.6), Swimming sets MOVE_Flying, leaving swim sets Falling, and a Falling mode in deep water goes back to Flying. `OnMediumChanged` fires. WadingDepth, WadingSpeedFactor and Hysteresis are EditAnywhere. PR: https://github.com/chrisfaber95/my-game-project/pull/53 (into epic/F-014).
Checks: `unreal-editor.sh check` passed (build OK, CompileAllBlueprints 0 errors, 0 failed to load); clang-format 18.1.8 clean. No automated or PIE tests run. No assets changed.
Reviewer: the Flying/Falling switching vs `RestoreMovement` (no flicker), and that the wading modifier stays during traversal. Swim input, dive and float are G-051.

## Review (reviewer writes, one line per round)
round 1: approve
