---
id: G-046
kind: ticket
repo: my-game-project
base: epic/F-011
branch: team/G-046
owner: eng-my-game-project
brief: F-011
depends_on: [G-041, G-043, G-044, G-045]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: true
user_ok: false
pr: 49
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
New `/Game/Maps/Greybox/L_CombatArena` (only asset changed; Python commandlet). PR #49 (https://github.com/chrisfaber95/my-game-project/pull/49) into epic/F-011, not merged.
Layout: 4000x4000 cm walled floor, AIndyGameMode, guard with 4 patrol points, dog, cover wall + 2 crates, closed safe room (baffled entrance) with ammo + medkit, 2nd medkit in a far corner, NavMeshBounds + RecastNavMesh over the floor.
Values (all defaults, nothing tuned): player 100 HP; pistol 25 dmg, 8+16 shots, ammo pickup +12; enemies 100 HP (4 hits each); guard ranged 10 dmg/1.5 s, melee 15/1.0 s; dog melee 12/0.8 s, speed 650; medkit +50.
Checks: `unreal-editor.sh check` exit 0 (0 errors, 0 failed to load); headless reload confirmed actors, patrol points, nav, game mode.
Placeholders: none.
NOT DONE: PIE (headless): patrol/notice/chase/shoot/bite, pickups, completion in both views, death restart. User play-test needed; numbers untuned. Reviewer: LFS pointer, only the .umap changed.

## Review (reviewer writes, one line per round)
