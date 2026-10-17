---
id: F-013
title: Game shell - HUD, pause, checkpoints, settings
status: approved
priority: should
repos: [my-game-project]
---
## Problem
A playable slice needs menus, saved progress and settings, or it can only be tested from the editor.

## Outcome
The game can be started, paused, resumed and re-entered from a saved checkpoint, and settings are kept
between sessions.

## User stories
- As the player, I can pause and resume so that I can take a break.
- As the player, I can quit and later continue from my last checkpoint so that I don't lose progress.
- As the player, I can change view, FOV, sensitivity and key bindings so that the game fits me.

## Acceptance criteria
- [ ] A start screen has New Game, Continue (only when a save exists), Settings and Quit.
- [ ] Pause shows Resume, Settings and Quit to menu; the game world is frozen while paused.
- [ ] Reaching a checkpoint saves progress (position, health, ammo, level state); Continue restores it after a full restart of the game.
- [ ] Settings include: default camera view, FOV, look sensitivity, key/button remapping; they are kept after restart.
- [ ] The level-end summary screen from F-012 offers Back to menu.
- [ ] The HUD shows only health (bottom-left) and, when armed, ammo.

## Out of scope
Multiple save slots, graphics-quality options, localization, achievements.

## Open questions
- None.

## Questions from lead
