---
id: G-008
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-007]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
A greybox test map where every F-009 movement can be tried in both views.

## Acceptance
- [ ] The map has stairs, a ledge to jump onto, a low-ceiling space that needs crouching and an open area large enough to roll; all are usable in both views.
- [ ] The map opens with `AIndyGameMode` and the player spawns on it.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets: `/Game/Maps/Greybox/L_Greybox` (new; basic shapes from `LevelPrototyping` by reference). Size the geometry to the capsule from G-001.
- `user_check: true`: the user plays the map and tunes speeds, jump height and roll distance (F-009 open question).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
