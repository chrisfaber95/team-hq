---
id: G-084
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 62
---
## Goal
View settings persist between sessions and include a default-view setting.

## Acceptance
- [ ] FOV, look sensitivity and default view are saved and reloaded after restart
- [ ] Changes apply immediately without reload
- [ ] Test covers save and load round-trip
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Camera/IndyViewSettings; own save slot. Settings apply immediately.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
round 1: approve

PR: https://github.com/chrisfaber95/my-game-project/pull/62 (into epic/F-013, not merged).
Changed: `UIndyViewSettings` gets `bDefaultFirstPerson`, own slot `ViewSettings`, `Save()`/`Load()` (Load on Initialize, clamped, version checked) and `OnDefaultViewChanged`; new `UIndyViewSettingsSave`; `AIndyCharacter::BeginPlay` snaps to the saved default view and `SetFirstPerson` follows later changes. FOV and sensitivity already applied live. Save is explicit (settings screen calls it on Back, a later ticket). No assets, no new dependencies.
Checks: `unreal-editor.sh check` passed (build, CompileAllBlueprints 0 errors); automation tests `ViewSettings.Clamp` and `ViewSettings.RoundTrip` pass; clang-format 18.1.8 clean.
Reviewer: the BeginPlay snap and the delegate follow are not covered by an automated test (needs PIE).
