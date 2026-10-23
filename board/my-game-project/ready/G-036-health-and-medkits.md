---
id: G-036
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The player has fragile health that drops on damage, can carry medkits and use one to heal, and dies at zero health.

## Acceptance
- [ ] A `UIndyHealthComponent` on `AIndyCharacter` takes damage through the actor's `TakeDamage`; health never goes below 0 or above the max; at 0 it broadcasts `OnDied` once and ignores further damage.
- [ ] Medkits: a carried count with a tunable cap (`AddMedkits` returns how many fit); a Use Medkit input (H, gamepad D-pad up) uses one and restores a tunable amount up to max health; at full health or with none carried it does nothing.
- [ ] Defaults give original-style fragile health (a few guard shots kill); max health, medkit heal amount and cap are tunable. The existing fall damage (G-019) now lowers this health.
- [ ] Pure helpers for the damage/heal/medkit rules with an automation test (`MyGameProject.Combat`).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: new folder `Source/MyGameProject/Combat/` (health component + pure rules). The input goes in `AIndyCharacter::BuildInputMapping` like the others (actions are built in code, no input assets).
- The same component goes on enemies later (G-039); keep it free of player-only code. Death only broadcasts here: the arena restart is G-044, the debug text G-043.
- F-011 open question: numbers are starting defaults, balanced in F-012.
- Reviewer expects (from F-015): the new automation tests run headless (`Automation RunTests MyGameProject.<Area>`) with the result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
