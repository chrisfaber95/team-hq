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
review_rounds: 0
user_check: false
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
