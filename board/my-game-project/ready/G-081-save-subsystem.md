---
id: G-081
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
Add the Save/ module: IIndySaveable interface, save object, records and UIndySaveSubsystem (single slot) with New Game, Continue, Retry and Quit to menu.

## Acceptance
- [ ] Subsystem writes and reads one slot; Continue is available only when a save exists
- [ ] New Game overwrites the slot; Retry with no checkpoint restarts the level
- [ ] Round-trip of the save object is covered by an automation test
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Module Source/.../Save/. Single Checkpoint slot overwritten each time; New Game overwrites it.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
