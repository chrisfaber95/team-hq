---
id: G-018
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-017]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
One whip press on a chosen anchor swings the player across a gap of at least 6 m to the anchor's landing point.

## Acceptance
- [ ] A press attaches and plays a scripted arc (no physics rope) to the anchor's landing point, at least 6 m away, landing without further input.
- [ ] Releasing the whip button early during the arc drops the player (normal falling, fall damage applies).
- [ ] The arc time and curve height are tunable; the arc path is a pure helper with an automation test (start and end points exact).
- [ ] Works in first and third person, with keyboard+mouse and gamepad; the view toggle works during the move without dropping it.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. Uses the Swing mode of the mode component. First-person hands/arm on the whip are placeholders until F-015.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
