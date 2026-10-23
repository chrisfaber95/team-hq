---
id: G-044
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: [G-036]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
When the player dies the arena restarts: player at the start, all enemies alive, all pickups back.

## Acceptance
- [ ] On the player's `OnDied` (G-036) input stops, and after a tunable delay `AIndyGameMode` reloads the current level, so enemies and pickups come back as placed.
- [ ] The player restarts at the PlayerStart with full health and the default ammo and medkits.
- [ ] No save or checkpoint (that is F-013).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Player/IndyGameMode`. Reloading the map is the chosen reset (no per-actor reset code); F-013 replaces it with checkpoints.
- A death animation is not required (`Content/Characters/Mannequins/Anims/Death` exists if a pose is cheap).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
