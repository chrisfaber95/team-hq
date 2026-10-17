---
id: F-009
title: Dual-view player (greybox)
status: approved
priority: must
repos: [my-game-project]
---
## Problem
The original has a fixed 3rd-person camera and clumsy controls. The remake needs a playable character
that feels good in both 1st and 3rd person before anything else is built on it.

## Outcome
In a greybox test map the player moves, jumps and looks around, and swaps between 1st and 3rd person at
any time. Success: the user plays the map for a few minutes in both views and finds movement equally good.

## User stories
- As the player, I can walk, run and jump with keyboard+mouse or a gamepad so that I can explore.
- As the player, I can press one key to swap between 1st and 3rd person at any moment so that I choose the view that suits the situation.
- As the player, I can change FOV and look sensitivity so that the view is comfortable.

## Acceptance criteria
- [ ] Walk, run and jump work with keyboard+mouse and with a gamepad.
- [ ] One bound input toggles 1st/3rd person; it works while standing, running and in mid-air.
- [ ] The view change completes in under 0.5 s with a smooth blend (no cut, no snap of the character).
- [ ] In 3rd person the camera never shows the inside of a wall or floor when the player stands against geometry.
- [ ] Walk speed, run speed and jump height are identical in both views.
- [ ] In 1st person the character's own body does not block the view.
- [ ] FOV and look sensitivity can be changed in-game and apply to both views immediately.
- [ ] The greybox test map has stairs, a ledge to jump onto and a low ceiling space; all are traversable in both views.

## Out of scope
Climbing, whip, weapons, enemies, animations beyond placeholder, menus (see F-010, F-011, F-013).

## Open questions
- Does the character mesh/arms in 1st person need to be visible (shadow, hands)? Placeholder body is fine for now.

## Questions from lead
