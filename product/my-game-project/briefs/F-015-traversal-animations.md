---
id: F-015
title: Traversal, whip, fall and crouch/roll animations
status: handed-off
priority: must
repos: [my-game-project]
depends_on: [F-009, F-010]
user_check: true
---
## Problem
Climbing, ledge hanging, block pushing, crouching and rolling work (F-009, F-010) but the character has no
animation for them. Crouch and roll only have procedural placeholder motion; the climb, ledge and block moves
have nothing, so the character slides in its normal pose.

## Outcome
Every one of these moves shows a matching animation, in both camera views, in the F-010 test map. The
character reads as climbing, hanging, pushing, crouching and rolling, and the animation never fights the
gameplay (no sliding feet, no popping at the start or end of a move).

## User stories
- As the player, I see the character climb, hang, push and pull, crouch and roll so that each move looks like what I am doing.
- As the player in 1st person, I see my own hands and arms (and legs where they would be visible) doing the move, consistent with the full-body view in 3rd person.

## Acceptance criteria
Ladder
- [ ] Mounting at the bottom and at the top, climbing up and climbing down each play their own animation; the climb pace follows the player's movement (stopping the input stops the animation).
- [ ] Dismounting at the top and at the bottom plays an animation that ends in the normal standing pose without a visible jump.

Climbable wall
- [ ] Climbing up, down, left and right each play a matching animation, and holding still on the wall shows a hanging/idle pose.
- [ ] Topping out at the end of the marked area plays a pull-up animation that ends standing on top.

Ledge
- [ ] Grabbing a ledge plays a grab animation that ends in a hang pose with the hands on the ledge.
- [ ] Shimmying left and right plays a shimmy animation that follows the shimmy speed and stops when the player stops.
- [ ] Climbing up plays a pull-up animation ending standing on the ledge; dropping plays a release and falls.

Block
- [ ] Pushing and pulling a block play push and pull animations with the hands on the block, only while the block moves; standing at a block without input shows a ready pose or normal idle.
- [ ] Letting go (or the block stopping at a wall) returns to normal idle without a visible jump.

Whip swing and falls
- [ ] Attaching the whip, the swing arc and the landing at the anchor each play a matching animation; releasing early plays a falling pose.
- [ ] Falling plays a falling animation, and landing plays a landing animation that scales with the fall tier (light landing below the damage height, a heavy landing from a damaging fall).

Crouch and roll (ordered last)
- [ ] Standing to crouch and back, crouched idle and crouched walking each play a crouch animation; the feet stay on the floor.
- [ ] Rolling plays a roll animation over the roll duration and ends in the normal standing or running pose; cancelling the roll does not leave the character in a roll pose.
- [ ] These replace the placeholder crouch and roll motion from F-009 (G-011).

Quality
- [ ] Moving between idle, walking, running and any of these moves blends smoothly: no visible pop at the start or end of a move.
- [ ] Hands are roughly on the rung, wall, ledge or block; small gaps or clipping are acceptable (no IK required).

Assets
- [ ] Animations come first from the animation assets already in the project (the Voxel Vision Free Animation Library), then Epic sample content, then free packs, in that order; each move uses the earliest source that has a fitting animation.
- [ ] No animation pack is added to the project without the user's approval (it counts as a new dependency); the ticket lists which pack, its license and which moves use it.

Views and input
- [ ] Every animation above shows in 3rd person, and the 1st-person view shows hands and arms (and legs where visible) for the climbing, ledge and block moves.
- [ ] Toggling the camera during any of these moves does not restart or glitch the animation.
- [ ] Animations play the same with keyboard+mouse and gamepad.

Test map
- [ ] In the F-010 test map every move above can be done start to finish, and the animations are seen without debug tools.

## Out of scope
Aim, shooting and other combat animations (F-011); swimming (F-014);
new gameplay behaviour, speeds or hitboxes; facial animation; final art quality and foot/hand IK (free or sample animation assets
are enough for now); assets extracted from the original game files.

## Decisions
- Whip swing and fall/landing animations are part of this brief (user, no new approval needed).
- Work order: ladder, wall, ledge, block and whip/falls first; crouch and roll last.
- A move with no fitting animation in any allowed source does not block the others: the lead puts a backlog ticket for it on the board, marked as needing the user (`NEEDS-YOU.md`), and the rest ships.

## Open questions
- Which moves the Voxel Vision Free Animation Library already covers is unknown; the lead finds out first and escalates to the user for any pack needed for the rest.
- Whip swing and fall/landing animations may need a follow-up brief if wanted later.

## Questions from lead
