---
id: F-009
title: Dual-view player (greybox)
status: handed-off
priority: must
repos: [my-game-project]
---
## Problem
The original has a fixed 3rd-person camera and clumsy controls. The remake needs a playable character
that feels good in both 1st and 3rd person before anything else is built on it.

## Outcome
In a greybox test map the player moves, jumps, crouches, rolls and looks around, and swaps between 1st and
3rd person at any time. Movement is modern and responsive, not a copy of the original's feel. Success: the
user plays the map for a few minutes in both views and finds movement equally good.

## User stories
- As the player, I can walk, run, jump, crouch, roll and sidestep with keyboard+mouse or a gamepad so that I can explore and evade.
- As the player, I can press one key to swap between 1st and 3rd person at any moment so that I choose the view that suits the situation.
- As the player, I see my own body in 1st person so that the view feels grounded.
- As the player, I can change FOV (per view) and look sensitivity so that the view is comfortable.

## Acceptance criteria
View
- [ ] One bound input toggles 1st/3rd person; it works while standing, running, crouching and in mid-air.
- [ ] The swap is a smooth glide of about 0.3 s (between 0.2 s and 0.4 s); the player keeps control of movement during it, and there is no cut or snap of the character.
- [ ] 3rd person is over-the-shoulder; mouse or right stick orbits the camera freely.
- [ ] In 3rd person the camera pulls in and never shows the inside of a wall, floor or ceiling when the player stands or crouches against geometry.
- [ ] In 1st person the camera sits in the head and the player sees their own legs and shadow; the body never blocks the view and the camera never clips through it.

Movement
- [ ] Walk, run and jump work with keyboard+mouse and with a gamepad.
- [ ] Movement feels responsive: input to movement start is under 0.1 s, the player can steer in mid-air, jumping is still possible for 0.1 s after walking off a ledge, and a jump pressed up to 0.1 s before landing is executed on landing.
- [ ] Walk speed, run speed, crouch speed and jump height are identical in both views.
- [ ] In 3rd person the character turns to face its move direction while free-running, and faces the camera direction while aiming.
- [ ] Crouch is held or toggled by one input; the player passes under a low ceiling only while crouched, and cannot stand up while the space above is too low.
- [ ] Roll is one input, moves the player a fixed distance in the current move direction (or forward when standing still), and cannot be started in mid-air.
- [ ] Sidestep: while aiming, movement input strafes around the aim direction with the character facing the aim point; when not aiming, left/right input is plain lateral movement with free-run facing.
- [ ] Crouch, roll and sidestep work in both views.

Settings
- [ ] FOV can be set separately for 1st and 3rd person and look sensitivity can be changed in-game; both apply immediately.

Test map
- [ ] The greybox map has stairs, a ledge to jump onto, a low-ceiling space that needs crouching, and an open area big enough to roll; all are usable in both views.

## Out of scope
Climbing, whip, weapons, enemies (including a real aim/target system: aiming here only needs a test input that
sets the aim direction), animations beyond placeholder, menus (see F-010, F-011, F-013). Invert Y and key
rebinding are not part of this brief.

## Open questions
- Exact tuning values (speeds, jump height, roll distance) are set by the user while playing the test map.

## Questions from lead
