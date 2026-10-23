---
id: G-082
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-081]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 65
---
## Goal
Health, pistol, enemy, pickup and push block save and restore their state.

## Acceptance
- [ ] Health, ammo and inventory restore after save/load
- [ ] Dead enemies stay dead; collected pickups stay collected; push block position restores
- [ ] Automation test per class saves, mutates and restores
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Mark fields UPROPERTY(SaveGame), implement IIndySaveable and OnStateRestored. One kind of change across existing classes.

## Hand-off (engineer writes, max 300 tokens)
PR #65 (https://github.com/chrisfaber95/my-game-project/pull/65) into epic/F-013. Tagged SaveGame: health (Health, Medkits, bDead), pistol (Magazine, Reserve), enemy bDead, pickup Amount. Enemy, pickup and push block implement OnStateRestored (enemy: new ApplyDeadState shared with HandleDied, no OnEnemyDied on restore). Also fixed UIndySaveSubsystem::CaptureObject: ArNoDelta=true, since delta serialization skipped default-valued fields so restore did not overwrite changed values. New Tests/IndySaveAdoptionTest.cpp (+ IndySaveTestActors.h concrete subclasses). Checks: unreal-editor.sh check passed (build, 0 BP errors); RunTests MyGameProject 74/74. No assets changed. Reviewer: check the ArNoDelta change (touches the G-081 core) and the push block restore (no SaveGame fields; position comes from the transform). Not done: PIE check, pistol mid-reload state.

## Review (reviewer writes, one line per round)
round 1: approve
