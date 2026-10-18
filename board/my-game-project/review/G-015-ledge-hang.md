---
id: G-015
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-014]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr: 19
---
## Goal
The player grabs a marked ledge by jumping toward it, shimmies along it, climbs up or drops.

## Acceptance
- [ ] Jumping toward a marked ledge grabs it automatically (forgiving reach, tunable).
- [ ] While hanging, left/right shimmies and stops at the end of the marked ledge; climb up ends standing on top; drop lets go.
- [ ] An unmarked edge cannot be grabbed.
- [ ] Works in first and third person, with keyboard+mouse and gamepad; the view toggle works during the move without dropping it.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. Grab detection must work from a normal jump arc and be forgiving, not pixel-precise.

## Hand-off (engineer writes, max 300 tokens)
Added `UIndyLedgeComponent` (Traversal/IndyLedgeComponent.{h,cpp}), wired into `AIndyCharacter` as `LedgeHang`. Airborne grab of a Ledge volume when hands are near its top, within reach of a long face and moving toward it; shimmy along the long axis stops at the ends; Jump climbs up, Crouch drops; tunables and Grabbed/Released events exposed in `Traversal|Ledge`. No assets changed.
PR: https://github.com/chrisfaber95/my-game-project/pull/19 (into epic/F-010). Check: `unreal-editor.sh check` passed (build + CompileAllBlueprints). No PIE run, no automated tests.
Reviewer: look at TryGrab conditions, shimmy direction sign in TickComponent, climb-up placement in Finish.

## Review (reviewer writes, one line per round)
