---
id: F-011
title: Combat and survival
status: approved
priority: must
repos: [my-game-project]
---
## Problem
The original is a puzzle/shooter: the player fights with a pistol and whip, takes damage, finds pickups
and restarts from a checkpoint. None of that exists yet.

## Outcome
In a test arena the player can fight two enemy types, be hurt, heal, run out of ammo, die and respawn,
using both camera views.

## User stories
- As the player, I can aim and fire a pistol so that I defeat enemies at range.
- As the player, I can lash the whip at a close enemy so that I stun or damage it.
- As the player, I can see my health and use medkits so that I know how risky it is to go on.
- As the player, I return to the last checkpoint on death so that I can try again.

## Acceptance criteria
- [ ] In 1st person, aiming zooms to sights; in 3rd person, aiming moves to an over-the-shoulder view with a crosshair; both fire the pistol where the crosshair points.
- [ ] The pistol has limited ammo; an empty pistol cannot fire and shows it.
- [ ] A whip lash damages an enemy within 3 m in front of the player, in either view.
- [ ] There are two enemy types: a human guard (patrols, notices the player by sight, shoots or strikes) and an animal (e.g. a dog; charges the player when noticed). Both can be killed.
- [ ] Health is shown as a bar bottom-left of the screen; it reduces on damage and fills on a medkit pickup (not above maximum).
- [ ] Ammo and medkit pickups exist in the world and are collected by walking into them.
- [ ] At zero health the player dies and respawns at the most recent checkpoint with the level state of that checkpoint (dead enemies stay dead, pickups already taken stay taken).
- [ ] A test arena has one of each enemy, one checkpoint and both pickups.

## Out of scope
Shotgun/rifle/machete and other weapons, bosses, advanced enemy squad AI, stealth takedowns, hints.

## Open questions
- Pistol ammo/damage numbers: start with tunable defaults, balance in F-012.

## Questions from lead
