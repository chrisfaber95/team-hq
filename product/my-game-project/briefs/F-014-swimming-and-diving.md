---
id: F-014
title: Swimming, diving and wading
status: handed-off
priority: must
repos: [my-game-project]
depends_on: [F-009, F-010, F-011]
---
## Problem
Babylon's water tunnels (F-012) and many later levels need the player to wade, swim and dive. The
player has no water behaviour yet.

## Outcome
In a test pool the player can wade through shallows, swim freely, dive under, hold their breath, run out
of air, find air pockets, climb out, fight and pick up treasure, in both camera views.

## User stories
- As the player, I can wade through shallow water so that I cross trenches and cave floors, more slowly.
- As the player, I can swim in deep water in any direction so that I explore flooded tunnels.
- As the player, I watch an air bar while underwater so that I know how long I can stay.
- As the player, I can refill air at the surface or an air pocket so that I survive long tunnels.
- As the player, I can climb out at marked edges so that I get back onto land.

## Acceptance criteria
Water volumes
- [ ] Water is a level-builder-placed volume with a depth: below a tunable wading depth the player wades, deeper the player swims.
- [ ] Wading: movement is slower by a tunable factor, jumping still works, and nothing else changes.
- [ ] Entering deep water switches to swimming without a button; leaving it back to wading or ground switches back.

Swimming and diving
- [ ] Swimming is free 3D: movement is relative to the camera (forward moves where the camera points, including up and down), with a dive input and a surface input; it works the same in 1st and 3rd person.
- [ ] At the surface the player floats with head above water; diving puts the head underwater and the camera under the surface with a visible water cue.
- [ ] Swimming speed is slower than running and tunable.

Air
- [ ] Underwater, an air meter drains at a tunable rate and refills quickly at the surface.
- [ ] At zero air the player takes damage at a tunable rate until they surface or die.
- [ ] Air pockets are level-builder-placed volumes underwater; inside one the player can breathe and the meter refills.
- [ ] Air is shown as simple on-screen debug text (the final HUD is F-013).

Actions in water
- [ ] The pistol and the whip work while swimming or at the surface, in both views (damage and range tunable; the whip's 3 m range is unchanged).
- [ ] Marked ledges and climbable edges (F-010 marking) let the player climb out of the water; an unmarked edge cannot be climbed.
- [ ] Treasure and other pickups underwater are collected by swimming into them.
- [ ] Blocks can be pushed and pulled underwater, with the F-010 block rules.

Test pool
- [ ] The pool has shallows, deep water, a two-level tunnel with an air pocket, an underwater treasure, an underwater block and a marked exit ledge; it can be completed in both views.

## Out of scope
Water physics and currents, boats or vehicles, swimming animations beyond placeholders, underwater
audio and effects, sharks or other water enemies, flooding or draining water as a puzzle.

## Open questions
- Numbers (air capacity, drain rate, damage at zero air, speeds): tunable defaults, balanced in F-012.
- Enemies do not follow or shoot the player in water (user confirmed 2026-10-17); decide when a level needs it.

## Questions from lead
