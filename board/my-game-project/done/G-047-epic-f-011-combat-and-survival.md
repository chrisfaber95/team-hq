---
id: G-047
kind: epic
repo: my-game-project
base: main
branch: epic/F-011
owner: lead
brief: F-011
depends_on: [G-036, G-037, G-038, G-039, G-040, G-041, G-042, G-043, G-044, G-045, G-046]
contracts: []
labels: [deps]
budget_usd: 0
review_rounds: 2
user_check: false
user_ok: true
pr: 51
---
## Goal
In a test arena the player can fight two enemy types, be hurt, heal, run out of ammo, die and try again, using both camera views. Fights feel tense like the original: health is fragile and ammo is scarce.

## Acceptance
- [ ] All acceptance criteria of `product/my-game-project/briefs/F-011-combat-and-survival.md` (pistol, whip, enemies, health and pickups, death, test arena).
- [ ] Full CI green on the epic PR.

## Notes (lead)
- Tickets: G-036..G-046. Never dispatched; `epic.sh pr G-047` once they are all in `done/`.
- The epic PR body lists every placeholder asset from the hand-offs, so the user knows what to replace.

- Assets: BP_EnemyDog, BP_EnemyGuard, BP_Pickup_Medkit, BP_Pickup_PistolAmmo, L_CombatArena, SM_Dog, SM_Medkit, SM_AmmoBox_Pistol, MI_Dog, MI_Medkit, MI_AmmoBox_Pistol (copied from the PR body, which lists them; reviewer round 2).

## Hand-off (engineer writes, max 300 tokens)
Assets: BP_EnemyDog, BP_EnemyGuard, BP_Pickup_Medkit, BP_Pickup_PistolAmmo, L_CombatArena, SM_Dog, SM_Medkit, SM_AmmoBox_Pistol, MI_Dog, MI_Medkit, MI_AmmoBox_Pistol.
Placeholders: SM_Dog, SM_Medkit, SM_AmmoBox_Pistol (copies of SM_ChamferCube); MI_Dog, MI_Medkit, MI_AmmoBox_Pistol (M_FlatCol colours).
Checks: per-ticket `unreal-editor.sh check` (0 errors) and headless MyGameProject.Combat, .AI and .Traversal tests passed; CI green. PR #51 title and body fixed (lead).
New dependency: Build.cs modules AIModule, GameplayTasks, NavigationSystem (G-040, user_ok given there); this epic needs user_ok for `deps`.

## Review (reviewer writes, one line per round)
round 1: changes - (1) PR body must list every placeholder asset from the hand-offs (the 11 changed .uasset/.umap: BP_EnemyDog/Guard, MI/SM_Dog, L_CombatArena, pickups BPs/MI/SM) as the Notes promise, and under "Assets:" in this ticket; (2) PR body says "Tests/checks: Not provided" and the hand-off is empty: name the check run on the epic (compile + automation tests for the new *RulesTest files), and fix the title "F-011: # Problem"; (3) Build.cs adds AIModule, GameplayTasks, NavigationSystem (new modules = new dependency): needs user_ok / NEEDS-YOU line (added). Code wiring across tickets (whip→enemy, game-mode restart, HUD, pistol/aim inputs) looks consistent, no leftover TODOs; CI green.
round 2: approve - round-1 items fixed in PR body (title, assets and placeholders listed, checks named, Build.cs modules approved on G-040); CI green; tickets G-036..G-046 cover the brief and fit together.
