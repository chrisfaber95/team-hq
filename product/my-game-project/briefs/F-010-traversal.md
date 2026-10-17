---
id: F-010
title: Traversal - climb, ledge, push blocks, whip swing
status: approved
priority: must
repos: [my-game-project]
---
## Problem
The original's platforming and puzzles rely on climbing, hanging from ledges, pushing blocks and
swinging on the whip. Without these the levels cannot be built.

## Outcome
The player can cross marked obstacles using these four moves, in both camera views, in a test map.

## User stories
- As the player, I can climb marked walls and ladders so that I reach higher areas.
- As the player, I can hang from a ledge and shimmy sideways so that I cross gaps and drops.
- As the player, I can push and pull a block so that I solve block puzzles.
- As the player, I can use the whip on a marked anchor to swing across a gap.

## Acceptance criteria
- [ ] Marked climbable surfaces and ladders can be climbed up and down and left/right on walls; an unmarked wall cannot be climbed.
- [ ] Jumping towards a marked ledge grabs it; the player can shimmy left/right, climb up, or drop.
- [ ] A block can be pushed and pulled along a straight line; it stops at walls and other blocks.
- [ ] A whip anchor within range can be targeted; using the whip swings the player across a gap of at least 6 m and lets go on landing or on the player's input.
- [ ] A fall of more than a set height (tunable) damages the player; a shorter fall does not.
- [ ] All four moves work in 1st and in 3rd person, and the camera toggle works while using them without dropping the move.
- [ ] A test map contains one example of each, in a row, passable by a player without debug tools.

## Out of scope
Combat, enemies, level art, vehicles (rafts, mine carts).

## Open questions
- In 1st person, do we show hands/arm on the whip and ledge? Placeholder is fine; decide when the art is added.

## Questions from lead
