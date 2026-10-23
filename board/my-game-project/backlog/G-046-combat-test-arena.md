---
id: G-046
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: [G-041, G-043, G-044, G-045]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr:
---
## Goal
A greybox test arena where the player can fight the guard and the dog, pick up ammo and medkits, die and try again, in both views.

## Acceptance
- [ ] New map with `AIndyGameMode`: one patrolling guard (3+ patrol points), one dog, at least one medkit and one ammo pickup, cover that blocks the guard's sight, and a safe spot out of every enemy's sight to reload and heal; the nav mesh covers the floor.
- [ ] The arena can be completed (both enemies dead) in first and in third person with normal input only; dying restarts it (G-044).
- [ ] Default numbers make fights tense (ammo in the arena is just enough, a few hits kill); list the values used in the hand-off.
- [ ] In the arena, the G-045 Blueprints behave: the guard patrols, notices, chases, shoots and strikes; the dog charges and bites; medkit and ammo pickups add to the counts (moved here from G-045; the user's play-test confirms it).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets: `/Game/Maps/Greybox/L_CombatArena` (new). Same method as G-008/G-020 (Python commandlet, editor stopped with `bash N:/team-hq/scripts/unreal-editor.sh stop my-game-project`). Shapes from `LevelPrototyping` by reference; place the G-045 Blueprints by class. Do not edit `L_Greybox` or `L_Traversal`.
- Placeholder rule (user, 2026-10-23): when the ticket needs an asset that is not in `Content/` yet (mesh, material, sound, icon), make a placeholder under the asset's real name and in the folder where the real one belongs (UE prefixes `SM_`/`SKM_`/`M_`/`MI_`/`S_`/`T_`), built from `LevelPrototyping` shapes or an existing asset, so the real asset can later replace it under the same name with no reference changes. Never import from Fab/Marketplace (that is a new dependency: stop and write it in the ticket). List every placeholder in the hand-off under `Placeholders:`.
- `user_check: true`: the user plays the arena and tunes the numbers (brief open question) before it merges.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
