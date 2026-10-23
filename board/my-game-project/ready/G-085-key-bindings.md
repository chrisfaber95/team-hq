---
id: G-085
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
Key and mouse remapping with persistence; the character rebuilds its input mapping on change.

## Acceptance
- [ ] A remapped key is used by the character immediately
- [ ] Bindings persist after restart and can reset to default
- [ ] Test covers save and load round-trip
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Player/IndyKeyBindings; own save slot. Default pause key is the engineer's call (e.g. Escape); the user checks in play.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
