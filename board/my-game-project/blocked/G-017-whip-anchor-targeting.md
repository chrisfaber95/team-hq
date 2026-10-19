---
id: G-017
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-016]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The player can pick a whip anchor: the best one in range is highlighted, the crosshair can choose another, and with none in range the whip does nothing.

## Acceptance
- [ ] One whip button, same in both views. An anchor within a tunable range and facing the player is highlighted.
- [ ] If the crosshair points at an anchor in range it is chosen; if none is aimed at, the nearest anchor in range is chosen (pure selection helper with an automation test).
- [ ] With no anchor in range or facing, the whip whiffs: no swing starts, and an event `OnWhipWhiffed` fires.
- [ ] Works in first and third person, with keyboard+mouse and gamepad; the view toggle works during the move without dropping it.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. Targeting only: pressing the button with a valid anchor broadcasts `OnWhipTargetChosen` and stops there; the arc is G-018. F-011 reuses the same button for the whip lash against enemies (3 m); keep the input action reusable.

- Run 1 stopped after 3 turns with uncommitted work in the worktree (whip anchor, component, selection helper, test, IndyCharacter edits). Continue from it: do not start over; finish, run `unreal-editor.sh check`, open the PR, write the hand-off, move to review/. The `## Review` section is empty; there is nothing to rework.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
