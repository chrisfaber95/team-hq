---
id: F-010
title: Traversal - climb, ledge, push blocks, whip swing
status: handed-off
priority: must
repos: [my-game-project]
---
## Problem
The original's platforming and puzzles rely on climbing, hanging from ledges, pushing blocks and
swinging on the whip. Without these the levels cannot be built.

## Outcome
The player can cross marked obstacles using these four moves, in both camera views, in a test map.
The moves are readable (the player can tell what is grabbable) and forgiving, not pixel-precise.

## User stories
- As the player, I can climb ladders and marked climbable walls so that I reach higher areas.
- As the player, I can hang from a ledge and shimmy sideways so that I cross gaps and drops.
- As the player, I can push and pull a block so that I solve block puzzles.
- As the player, I can use the whip on an anchor to swing across a gap.
- As the player, I take damage from high falls so that drops carry risk.

## Acceptance criteria
Marking (applies to climbable walls, ladders, ledges, whip anchors)
- [ ] Each of these is a level-builder-placed volume plus a visible cue, so the player can tell it is usable; an unmarked wall or edge cannot be climbed or grabbed.

Climb
- [ ] Ladders are a separate mode: up/down only, with a mount and dismount at top and bottom.
- [ ] Marked climbable walls allow up, down, left and right; leaving the marked area at the top ends in standing on top.
- [ ] While climbing or hanging, the player can look around freely in both views; movement stays on the wall or ledge and the camera never clips into the wall.

Ledge
- [ ] Jumping towards a marked ledge grabs it automatically; the player can shimmy left/right, climb up, or drop.
- [ ] Shimmy stops at the end of the marked ledge.

Block
- [ ] A block can be pushed and pulled while the player holds the input, sliding continuously along one straight axis; it stops at walls and other blocks.

Whip swing
- [ ] A whip anchor in range and facing the player is highlighted; the player can also aim at an anchor with the crosshair to choose it, and if none is aimed, the nearest anchor in range is used. One whip button, same in both views.
- [ ] One press attaches and plays a scripted arc across a gap of at least 6 m to the anchor's landing point; the player lands there without further input.
- [ ] Releasing early during the arc drops the player.
- [ ] Using the whip when no anchor is in range or facing does not swing (the whip whiffs).

Falls
- [ ] Fall damage is tiered by height: no damage below a safe height, increasing damage above it, lethal above a maximum height. All three heights are tunable.

Views and input
- [ ] All four moves work in 1st and in 3rd person, and the camera toggle works while using them without dropping the move.
- [ ] All four moves work with keyboard+mouse and gamepad.

Test map
- [ ] A test map contains one example of each (ladder, climbable wall, ledge, block, whip anchor) in a row, passable by a player without debug tools.

## Out of scope
Combat, enemies, level art, vehicles (rafts, mine carts), stamina, blocks that crush the player, invert-Y and key rebinding, extra negative-case or fall-tier test map sections.

## Open questions
- Exact fall heights (safe, damage scale, lethal) are decided later, while playing the test map.

## Decisions
- Whip targeting confirmed by the user: highlight in range, crosshair aim chooses, nearest anchor as fallback.
- In 1st person the player's hands and arm are shown on the whip and ledge grab (consistent with the full-body view in F-009); a placeholder is fine until the art is added.

## Questions from lead
