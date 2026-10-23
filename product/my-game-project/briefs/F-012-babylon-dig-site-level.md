---
id: F-012
title: Babylon dig site level (first half)
status: handed-off
priority: must
repos: [my-game-project]
depends_on: [F-009, F-010, F-011, F-013, F-014]
user_check: true
---
## Problem
The moves and combat only become a game when they are put together in a level. Babylon dig site is
the original's second level and the chosen vertical slice.

## Outcome
The first half of Babylon, start to a stand-in exit at the end of the underwater tunnels, following the
original's area order and puzzle flow (1:1), playable in either camera view. Success: the user plays it
start to finish without debug tools (the user approves it before the epic merges).

## Reference
Area order and puzzle flow come from two text walkthroughs (the user's GameFAQs link blocked the
designer, HTTP 403): cyberly.org and coregamers.com (links in `research/`). They agree on order but
differ on small details; the user corrects anything that differs from their memory. The designer
cannot read the original game files.

Slice areas, in order:
1. Ruins exterior: cross the ditch by the central columns, climb a wall and ledges to the rooftops, overhear the general, cross roofs to the camp (four guards).
2. Cave and two-storey building: dark spider room, ledge route, water-filled trench (wade only, shallow).
3. Barrel cave: shoot the explosive barrels to kill a guard, fight the pursuing guards at the narrow gates.
4. Camp and tent area: medkits, a decline into an underground room, hallway guard and scorpion, lever and crank open a gate.
5. Compound: push and climb crates to the roof, time a jump onto the passing truck; base battle (three guards, a sniper, gas containers/barrels).
6. Base interior and water tunnels: dark room with coins, lever in the niche (reinforcements), pull a crate to reveal the passage, swim the two-level tunnel to the stand-in exit door.

## User stories
- As the player, I can explore the dig site, solve its puzzles and reach the exit so that I complete the slice.
- As the player, I can find treasures and secrets so that my Indy Quotient score at the end reflects it.

## Acceptance criteria
- [ ] The slice has a start, a final exit trigger (the sealed door at the end of the water tunnel) and an end-of-level screen.
- [ ] Areas 1-6 appear in the order above, matching the walkthrough layout.
- [ ] Mandatory chains, none skippable by walking round: (a) lever, then crank, then gate (tent area); (b) push crate, climb to roof, jump onto the truck; (c) shoot the barrels to kill the cave guard; (d) pull the crate to reveal the tunnel, then swim it.
- [ ] Enemies: guards, spiders and scorpions (the F-011 animal in two variants), placed in at least three encounters, plus the sniper. The level has at least two checkpoints.
- [ ] Every traversal move from F-010 is needed at least once; swimming and diving (F-014) are needed in the tunnel.
- [ ] Treasures are picked up and counted, placed at the rough walkthrough locations (cave ledges, roof, tent area, base, underwater tunnel); the end screen shows treasures found / total and secrets found / total.
- [ ] At least one secret area is reachable only by an optional route.
- [ ] Story beats (the general overheard, reinforcements) are one-line on-screen text cards; no cutscenes.
- [ ] A full run from start to exit is possible in one session, and again after dying and respawning at a checkpoint.
- [ ] Uses greybox/placeholder or free assets only.

## Out of scope
The second half (key and TNT room, mechanism room, library, tablet puzzle, elevator, jeep), other levels,
vehicles, cutscenes and story dialogue, the hint system, final art and audio.

## Open questions
- Swimming is now needed (water tunnel). F-014 (swimming and diving, air meter) must exist and be done before this brief's tickets; the designer proposes writing it next.
- Treasure and secret counts are approximate; the walkthrough lists them loosely. The user checks them from memory.
- The original ends this stretch at the sealed door where the CIA agent hands over a key; here it is a plain exit trigger. Confirm.
- The cave "dark room" and spider fights: scorpion and spider numbers (health, damage) tune in this level.

## Questions from lead

- Answered by the user 2026-10-18: the exit is a plain exit trigger (confirmed). The Indy Quotient score is not on the end screen; treasures and secrets counts only (F-013).
