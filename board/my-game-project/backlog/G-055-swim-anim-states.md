---
id: G-055
kind: ticket
repo: my-game-project
base: epic/F-014
owner: eng-my-game-project
brief: F-014
depends_on: [G-051]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The animation state machine has placeholder swim states, so swimming plays something.

## Acceptance
- [ ] `SwimIdle` and `Swim` are added to `EIndyMoveAnimState` and chosen from the swim medium and movement speed (automation test)
- [ ] Clip properties exist for both; with no clip assigned the graph stays visible and nothing crashes
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change (none)

## Notes (lead)
Design: `decisions/0015-f014-swimming-and-diving.md`. Module: `Source/MyGameProject/Animation/`; follow the pattern of G-025..G-031.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
