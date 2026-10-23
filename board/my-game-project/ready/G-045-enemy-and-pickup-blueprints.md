---
id: G-045
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: [G-040, G-042]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Blueprint children for the guard, the dog and the two pickups, with placeholder looks where real assets don't exist yet.

## Acceptance
- [ ] `BP_EnemyGuard` and `BP_EnemyDog` are children of `AIndyEnemyCharacter` using `AIndyEnemyAIController`, with defaults set (guard: ranged + melee; dog: melee only, faster, smaller capsule). Property values only, no graph logic.
- [ ] `BP_Pickup_Medkit` and `BP_Pickup_PistolAmmo` are children of `AIndyPickup` with kind, amount and a mesh.
- [ ] Each one works in PIE in a scratch level that is not saved: guard and dog patrol, notice and attack; pickups add to the counts (say how you checked in the hand-off).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets (new): `/Game/Characters/Enemies/Guard/BP_EnemyGuard`, `/Game/Characters/Enemies/Dog/BP_EnemyDog`, `/Game/Pickups/BP_Pickup_Medkit`, `/Game/Pickups/BP_Pickup_PistolAmmo`, plus the placeholders below.
- Guard look: `SKM_Manny_Simple` with the mannequin anim BP (exists). Missing, so placeholders: dog `/Game/Characters/Enemies/Dog/Meshes/SM_Dog` (a low box body from `SM_ChamferCube`), medkit `/Game/Pickups/Meshes/SM_Medkit`, ammo `/Game/Pickups/Meshes/SM_AmmoBox_Pistol`, each with an `MI_` material if it needs a colour.
- Placeholder rule (user, 2026-10-23): when the ticket needs an asset that is not in `Content/` yet (mesh, material, sound, icon), make a placeholder under the asset's real name and in the folder where the real one belongs (UE prefixes `SM_`/`SKM_`/`M_`/`MI_`/`S_`/`T_`), built from `LevelPrototyping` shapes or an existing asset, so the real asset can later replace it under the same name with no reference changes. Never import from Fab/Marketplace (that is a new dependency: stop and write it in the ticket). List every placeholder in the hand-off under `Placeholders:`.
- Property values only, so no `user_check` (decision 0010); the user sees them in the arena (G-046).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
