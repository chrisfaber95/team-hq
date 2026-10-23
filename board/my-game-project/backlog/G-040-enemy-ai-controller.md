---
id: G-040
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: [G-039]
contracts: []
labels: [deps]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Enemies patrol, notice the player by sight, chase and attack, and give up after losing the player.

## Acceptance
- [ ] `AIndyEnemyAIController` with sight perception: a tunable vision cone and range, blocked by walls; noticing the player switches from patrol to chase.
- [ ] Patrol: follows a list of points set on the enemy in the level (an editable array), looping; it returns to patrol after losing the player.
- [ ] Chase and attack: moves to the player on the nav mesh; a ranged enemy (guard) shoots from range and strikes in melee when close; a melee-only enemy (dog) charges and bites. No attacks while staggered or dead.
- [ ] Lost: after a tunable time without sight it stops chasing; the dog stops, the guard returns to patrol.
- [ ] Pure state-transition helper (patrol/chase/attack/lost) with an automation test (`MyGameProject.AI`).
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/AI/`. Needs `AIModule`, `NavigationSystem` and `GameplayTasks` in `MyGameProject.Build.cs`: a new dependency (`deps`), so `merge.sh` waits for the user's `user_ok`.
- Prefer plain C++ state logic in the controller over Behavior Tree / StateTree assets (keeps the ticket C++ only and testable).
- No squad AI (brief: out of scope).
- Reviewer expects (from F-015): the new automation tests run headless (`Automation RunTests MyGameProject.<Area>`) with the result in the hand-off.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
