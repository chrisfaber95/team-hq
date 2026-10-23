---
id: G-052
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-051]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 55
---
## Goal
When the camera is under the water surface the screen shows a visible tint, in both views.

## Acceptance
- [ ] A camera point inside a Water volume turns the post-process tint on; leaving turns it off
- [ ] A camera point inside an AirPocket does not tint
- [ ] Works in 1st and 3rd person
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: IndyCharacter view update in `Source/MyGameProject/Player/`. Post-process tint, no assets.

## Hand-off (engineer writes, max 300 tokens)
PR #55 (https://github.com/chrisfaber95/my-game-project/pull/55) into epic/F-014. `AIndyCharacter::UpdateUnderwaterTint` (called from `UpdateView`) tests the camera point: inside a Water volume and in no AirPocket turns the camera's SceneColorTint on (`PostProcessBlendWeight` 1, else 0). New `UnderwaterTint` property and `IsCameraUnderwater()`. The camera point is used in both views. Files: `Player/IndyCharacter.h/.cpp`; no assets.
Checks: `unreal-editor.sh check` exit 0 (build ok, CompileAllBlueprints 0 errors, 0 failed to load); clang-format 18.1.8 clean. No new automation test; no PIE check.
Reviewer: the tint switches instantly (no fade) and the colour is unbalanced; it runs a FindVolumes actor iteration twice per frame.

## Review (reviewer writes, one line per round)
round 1: approve
