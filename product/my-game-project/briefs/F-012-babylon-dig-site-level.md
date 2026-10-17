---
id: F-012
title: Babylon dig site level
status: approved
priority: must
repos: [my-game-project]
---
## Problem
The moves and combat only become a game when they are put together in a level. Babylon dig site is
the original's second level and the chosen vertical slice.

## Outcome
One complete level, start to end, that follows the original's Babylon layout and puzzle flow (1:1),
playable in either camera view. Success: the user plays it start to finish without debug tools.

## User stories
- As the player, I can explore the dig site, solve its puzzles and reach the exit so that I complete the level.
- As the player, I can find treasures and secrets so that my Indy Quotient score at the end reflects it.

## Acceptance criteria
- [ ] The level has a start, a final exit trigger and an end-of-level screen.
- [ ] The level's layout and the order of its areas and puzzles match the reference the user supplies (see Open questions).
- [ ] At least one multi-step puzzle chain (3 or more steps, e.g. lever, then block, then whip anchor, then gate) must be solved to progress; it cannot be skipped by walking round.
- [ ] Both enemy types from F-011 appear, placed in at least three encounters; the level has at least two checkpoints.
- [ ] Every traversal move from F-010 is needed at least once.
- [ ] Treasures can be picked up and are counted; at level end the screen shows treasures found / total and the secrets found / total.
- [ ] At least one secret area is reachable only by an optional route.
- [ ] A full run from start to exit is possible in one session, and again after dying and respawning at a checkpoint.
- [ ] Uses greybox/placeholder or free assets only.

## Out of scope
Other levels, vehicles, cutscenes and story dialogue, the hint system, final art and audio.

## Open questions
- Layout/puzzle reference for Babylon: the user supplies it (notes, video, map) before tickets are written. The designer cannot read the original game files.

## Questions from lead
