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
review_rounds: 0
user_check: false
user_ok: false
pr:
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
