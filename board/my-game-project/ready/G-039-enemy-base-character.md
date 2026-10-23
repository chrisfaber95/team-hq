---
id: G-039
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
A C++ enemy base character that can be hurt, staggered and killed, and that exposes its attacks for the AI to use.

## Acceptance
- [ ] `AIndyEnemyCharacter` (ACharacter) carries `UIndyHealthComponent` (G-036); pistol and whip damage lower its health; at 0 it dies (stops moving and attacking, no longer blocks the player, `OnEnemyDied`).
- [ ] `Stagger(Duration)`: while staggered it cannot attack or move; damage of the whip damage type staggers it for a tunable time.
- [ ] Attacks as callable functions with tunable damage, range and cooldown: `RangedAttack(Target)` (hitscan with a tunable miss spread) and `MeleeAttack(Target)` (within melee range); flags `bHasRangedAttack` / `bHasMeleeAttack`, so the guard and the dog are the same class with different defaults.
- [ ] Pure stagger/cooldown rules with an automation test (`MyGameProject.AI`).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: new folder `Source/MyGameProject/AI/`. No AI controller or perception here (G-040), so no new modules in `MyGameProject.Build.cs`.
- Add `UIndyWhipDamageType` (UDamageType) in `Combat/` for the stagger check; G-041 uses it.
- Guard and dog are Blueprint children later (G-045, decision 0013).
- Reviewer expects (from F-015): the new automation tests run headless (`Automation RunTests MyGameProject.<Area>`) with the result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
