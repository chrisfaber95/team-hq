---
id: F-011
title: Combat and survival
status: approved
priority: must
repos: [my-game-project]
---
## Problem
The original is a puzzle/shooter: the player fights with a pistol and whip, takes damage and finds
pickups. None of that exists yet.

## Outcome
In a test arena the player can fight two enemy types, be hurt, heal, run out of ammo, die and try again,
using both camera views. Fights feel tense like the original: health is fragile and ammo is scarce.

## User stories
- As the player, I can aim and fire a pistol so that I defeat enemies at range.
- As the player, I can reload so that I keep fighting while I have reserve ammo.
- As the player, I can lash the whip at a close enemy so that I stun or damage it.
- As the player, I can carry medkits and use one when hurt so that I choose when to heal.
- As the player, I restart the arena on death so that I can try again.

## Acceptance criteria
Pistol
- [ ] Aiming is held: holding the aim input aims, releasing lowers the weapon. In 1st person aiming zooms to sights; in 3rd person it moves to a tighter over-the-shoulder view with a crosshair; the character faces the aim point (F-009).
- [ ] Both views fire the pistol where the crosshair points.
- [ ] The pistol has a fixed magazine size plus reserve ammo; reload is one input; an empty magazine cannot fire and shows it; no reserve means reload does nothing.
- [ ] Magazine size, reserve cap and damage are tunable values.

Whip
- [ ] A whip lash hits an enemy within 3 m in front of the player, in either view, and needs no ammo.
- [ ] A hit enemy staggers briefly (cannot attack during the stagger) and takes small damage; repeated lashes can kill it.

Enemies
- [ ] Human guard: patrols, notices the player by sight (vision cone, blocked by walls), chases and shoots; strikes in melee when close; loses the player after a short time out of sight and returns to patrol.
- [ ] Animal (e.g. a dog): charges the player when noticed and bites; stops chasing after losing the player.
- [ ] Both enemy types can be killed with the pistol and with the whip.

Health and pickups
- [ ] Player health reduces on damage; a few hits kill (damage values tunable, original-style fragile health).
- [ ] Medkits are pickups collected by walking into them and carried (count shown, with a tunable cap); a button uses one, restoring health up to the maximum.
- [ ] Ammo pickups add to reserve ammo, up to its cap.
- [ ] Health, magazine/reserve ammo and medkit count are visible as simple on-screen debug text (the final HUD is F-013).

Death
- [ ] At zero health the player dies and the arena restarts: player at the arena start, all enemies alive, all pickups restored (checkpoints and saved state are F-013).

Test arena
- [ ] The arena has one guard, one animal, both pickup types and a spot where the player can reload and heal safely; it can be completed in both views.

## Out of scope
Shotgun/rifle/machete and other weapons, bosses, advanced enemy squad AI, stealth takedowns, hints, final HUD, checkpoints and saving (F-013), difficulty settings.

## Open questions
- Pistol and enemy numbers (damage, ammo caps, health): start with tunable defaults, balance in F-012.
- F-012 expects checkpoint behaviour: it comes with F-013, which is lower priority than F-012; the lead should order the work accordingly.

## Questions from lead
