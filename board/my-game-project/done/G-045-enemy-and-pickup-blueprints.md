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
review_rounds: 1
user_check: false
user_ok: false
pr: 47
---
## Goal
Blueprint children for the guard, the dog and the two pickups, with placeholder looks where real assets don't exist yet.

## Acceptance
- [ ] `BP_EnemyGuard` and `BP_EnemyDog` are children of `AIndyEnemyCharacter` using `AIndyEnemyAIController`, with defaults set (guard: ranged + melee; dog: melee only, faster, smaller capsule). Property values only, no graph logic.
- [ ] `BP_Pickup_Medkit` and `BP_Pickup_PistolAmmo` are children of `AIndyPickup` with kind, amount and a mesh.
- [ ] ~~Each one works in PIE in a scratch level that is not saved: guard and dog patrol, notice and attack; pickups add to the counts (say how you checked in the hand-off).~~ Moved to G-046 by the lead (2026-10-23): the engineer's editor is headless and can't play; the user's G-046 play-test covers it. Reviewer: don't hold this ticket on it.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change.

## Notes (lead)
- Assets (new): `/Game/Characters/Enemies/Guard/BP_EnemyGuard`, `/Game/Characters/Enemies/Dog/BP_EnemyDog`, `/Game/Pickups/BP_Pickup_Medkit`, `/Game/Pickups/BP_Pickup_PistolAmmo`, plus the placeholders below.
- Guard look: `SKM_Manny_Simple` with the mannequin anim BP (exists). Missing, so placeholders: dog `/Game/Characters/Enemies/Dog/Meshes/SM_Dog` (a low box body from `SM_ChamferCube`), medkit `/Game/Pickups/Meshes/SM_Medkit`, ammo `/Game/Pickups/Meshes/SM_AmmoBox_Pistol`, each with an `MI_` material if it needs a colour.
- Placeholder rule (user, 2026-10-23): when the ticket needs an asset that is not in `Content/` yet (mesh, material, sound, icon), make a placeholder under the asset's real name and in the folder where the real one belongs (UE prefixes `SM_`/`SKM_`/`M_`/`MI_`/`S_`/`T_`), built from `LevelPrototyping` shapes or an existing asset, so the real asset can later replace it under the same name with no reference changes. Never import from Fab/Marketplace (that is a new dependency: stop and write it in the ticket). List every placeholder in the hand-off under `Placeholders:`.
- Property values only, so no `user_check` (decision 0010); the user sees them in the arena (G-046).

## Hand-off (engineer writes, max 300 tokens)

PR #47 (https://github.com/chrisfaber95/my-game-project/pull/47) into epic/F-011. Content only, 10 new assets, property values only.
Changed: BP_EnemyGuard (ranged+melee, Manny + ABP_Unarmed), BP_EnemyDog (melee only, 650 speed, capsule r28/hh35, box body DogBody), BP_Pickup_Medkit (Medkit x1), BP_Pickup_PistolAmmo (PistolAmmo x12).
Checks: `unreal-editor.sh check` exit 0, CompileAllBlueprints 0 errors, 0 failed to load (first run hit an editor out-of-memory crash, rerun passed).
Placeholders: SM_Dog, SM_Medkit, SM_AmmoBox_Pistol (copies of SM_ChamferCube), MI_Dog, MI_Medkit, MI_AmmoBox_Pistol (M_FlatCol colours).
NOT DONE: the PIE check (patrol/notice/attack, pickups adding counts). Look at this first; a visual/PIE check is still needed.
Reviewer: the commit trailer names Haiku 5.5 instead of Sonnet 5.5.

## Review (reviewer writes, one line per round)
round 1: approve
