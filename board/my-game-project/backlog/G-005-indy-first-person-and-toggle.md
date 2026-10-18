---
id: G-005
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: [G-004]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
A first-person view that shows the player's own body, and one input that glides between first and third person in about 0.3 s.

## Acceptance
- [ ] In first person the camera sits in the head; the player sees their own legs and shadow; the body never blocks the view and the camera never clips through it.
- [ ] One bound input toggles first/third person while standing, running, crouching and in mid-air.
- [ ] The swap is a smooth glide of 0.2-0.4 s (default 0.3 s, tunable); movement keeps working during it and the character never cuts or snaps.
- [ ] Walk speed, run speed, crouch speed and jump height are identical in both views (an automation test reads the one source).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Camera/`. The placeholder mannequin in `Content/Characters/Mannequins` may be used by reference, not edited. How the body is hidden or shown per view is the engineer's call.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
