---
id: G-092
kind: epic
repo: my-game-project
base: main
branch: epic/F-013
owner: lead
brief: F-013
depends_on: [G-081, G-082, G-083, G-084, G-085, G-086, G-087, G-088, G-089, G-090, G-091]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
The game can be started, paused, resumed and re-entered from a saved checkpoint; dying has a clear consequence; settings persist. Design: decisions/0017-f013-game-shell.md.

## Acceptance
- [ ] Start screen, pause, death screen and settings behave as in brief F-013
- [ ] Checkpoint autosave to one slot; Continue after full restart restores world state
- [ ] HUD shows health always, ammo only when armed, air meter only underwater
- [ ] Full CI green on the epic PR

## Notes (lead)
Never dispatched to an engineer. Level-end summary (F-012 G-062) and G-058 follow-ups: see decision file.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
