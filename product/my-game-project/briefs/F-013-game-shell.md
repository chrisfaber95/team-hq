---
id: F-013
title: Game shell - HUD, pause, checkpoints, settings
status: handed-off
priority: should
repos: [my-game-project]
---
## Problem
A playable slice needs menus, saved progress and settings, or it can only be tested from the editor.

## Outcome
The game can be started, paused, resumed and re-entered from a saved checkpoint, dying has a clear
consequence, and settings are kept between sessions. Success: the user plays F-012 start to finish
from the start screen, quits mid-level, and continues exactly where the last checkpoint was.

## User stories
- As the player, I can pause and resume so that I can take a break.
- As the player, I can quit and later continue from my last checkpoint so that I don't lose progress.
- As the player, I can retry from my last checkpoint after dying so that a mistake costs me a short replay only.
- As the player, I can change view, FOV, sensitivity and key bindings so that the game fits me.

## Acceptance criteria
- [ ] A start screen has New Game, Continue (only when a save exists), Settings and Quit, on a plain greybox background (no confirmation dialogs anywhere in the shell).
- [ ] Pause (works in any state: walking, swimming, aiming, while a text card is shown) shows Resume, Restart from checkpoint, Settings and Quit to menu; the whole world is frozen while paused (enemy AI, physics, air meter, timers).
- [ ] Reaching a checkpoint autosaves to a single slot (overwritten each time; New Game also overwrites it). The save holds full world state: player position, health, ammo and inventory; state of levers, crates, gates and barrels; dead enemies; collected treasures and secrets.
- [ ] After a full restart of the game, Continue restores that state, and the F-012 mandatory chains (lever/crank/gate, crate/truck, barrels, crate/tunnel) are in the state they were at the checkpoint.
- [ ] Dying shows a death screen with Retry (reload the last checkpoint) and Quit to menu. With no checkpoint reached yet, Retry restarts the level.
- [ ] Settings include: default camera view, FOV, look sensitivity, key/mouse remapping; they apply immediately and are kept after restart. Reachable from both the start screen and pause.
- [ ] The level-end summary screen from F-012 shows treasures found / total and secrets found / total, and offers Back to menu.
- [ ] The HUD shows health (bottom-left) always; ammo only when armed; the air meter (F-014) only while underwater. Nothing else (story text cards are separate, from F-012).
- [ ] Menus work with keyboard and mouse.

## Out of scope
Gamepad support (menus and gameplay; could become its own brief later), multiple save slots, manual or quick save,
confirmation dialogs, graphics/resolution/audio options, a menu fly-by of the Babylon level (follow-up once F-012 exists),
localization, achievements, final menu art.

## Open questions
- Does the Indy Quotient score (mentioned in F-012's user stories) appear on the end screen? The current criteria show only treasure and secret counts; confirm.
- Default key bindings for the shell (pause key etc.) are the lead's call; the user checks them in play.

## Questions from lead

- Answered by the user 2026-10-18: the end screen shows treasure and secret counts only, no Indy Quotient score.
