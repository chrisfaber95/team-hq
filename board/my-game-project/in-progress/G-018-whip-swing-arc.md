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
review_rounds: 1
user_check: false
user_ok: false
pr: 22
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

- Lead decision for round 1 point 1: hold-to-swing. The player presses and holds the whip button; releasing before landing drops them, holding to the end lands them. A quick tap must not end the swing early or drop the player instantly, so the rule needs a way to tell a tap from a deliberate release (e.g. a short grace time, tunable and exposed). Say in the hand-off which rule you used. Point 2: run the arc test (or say why it cannot run) and report the result.

## Hand-off (engineer writes, max 300 tokens)
Added a scripted whip swing (no physics rope). `IndyWhipArc::Evaluate` is a pure arc helper (start/end exact) with automation test `MyGameProject.Traversal.WhipArc.Evaluate`. `UIndySwingComponent` takes Swing mode on `OnWhipTargetChosen`, moves the player to the anchor's new `LandingOffset`/`GetLandingLocation()`, lands with no input; releasing the whip drops (normal fall). `ArcTime`/`ArcHeight` tunable; events and properties have Categories. Character binds whip Completed/Canceled. PR: https://github.com/chrisfaber95/my-game-project/pull/22 (into epic/F-010). Ran: `unreal-editor.sh check` exit 0 (build ok, 0 BP errors). Automation test compiled but not run; no PIE check. Reviewer: the 6 m gap is level placement, not enforced in code; no anchor is placed in a map yet.

## Review (reviewer writes, one line per round)
round 1: changes - 1) WhipAction Completed fires when a normal tap is released, so the Drop() in WhipReleased ends the swing within a few frames and the arc never completes; the swing must survive a tap and only drop on a deliberate early release (e.g. hold-to-swing, or a distinct release rule), and the hand-off must say which. 2) The arc test was compiled but never run; run MyGameProject.Traversal.WhipArc.Evaluate (or name why it cannot run) and report the result.
