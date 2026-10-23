# 0016: F-012 Babylon dig site (first half): design and ticket split

Date: 2026-10-23. Decided by: the architect (for the planner). Brief: F-012. Repo: my-game-project. Depends on F-013 (no tickets yet) and F-014 (G-056, G-057 open).

## Decision

- **F-013 goes first and owns save, checkpoint and shell.** F-013 delivers `IIndySaveable`: state in `UPROPERTY(SaveGame)` fields, `OnStateRestored()` re-applies visuals. It adds the interface to the push block, enemy and pickup, and owns `AIndyCheckpoint` (F-012 only places it), respawn, pause, HUD, death screen and menu map. F-012's new classes implement it. Why: if F-012 went first, F-013 would edit every F-012 class again; only one game engineer works at a time, so the order costs nothing. Cut `epic/F-012` from `main` after the F-013 and F-014 epics merge.
- **F-012 builds in C++** (new `Level/` folder, widget bases in `UI/`): activation seam, gate, lever/crank, treasure, secret, stats, exit, end screen, text card, barrel and two enemy flags. F-013 does not ticket the end screen or text cards; its HUD stays health, ammo, air.
- **Activation seam**: `IIndyActivatable::Activate(AActor* Instigator)`. Lever, crank and barrel hold `TArray<TObjectPtr<AActor>> Targets`, set per instance in the map. Why: the chains are property data, not level-Blueprint logic in binary maps, and a world test covers them. Four target kinds need it (gate, locked switch, text card, dormant enemy), so it is not speculative.
- **`AIndySwitch`**: one class for lever and crank. A Blueprint child sets the mesh; `UseDelay > 0` makes a crank. With `bStartsLocked`, use does nothing and Activate unlocks it. Use is single-shot. **`AIndyGate`** moves its door by `OpenOffset` over `OpenTime`. Chain (a): the lever targets the crank, the crank the gate. The player uses a switch with the existing `InteractAction` (ladder > block > switch). No new input actions, so F-013 remapping is unaffected.
- **Treasure** is `EIndyPickupKind::Treasure` on `AIndyPickup`, always taken whole, no cap. Why not a new class: overlap, hide and F-013's collected-state save come for free.
- **`AIndySecretArea`** is a trigger box with `bFound` (SaveGame). **`UIndyLevelStats`** (a world subsystem) counts found and total treasures and secrets by iterating the placed actors on each query. Nothing is stored, so counts can't drift from content or a restored save.
- **`AIndyLevelExit`** fires once on player overlap: input off, UI cursor on, `EndWidgetClass` added. **`UIndyLevelEndWidget`**: `BindWidget` texts for both counts; `BackToMenu()` opens `MenuLevel` (a soft world on the exit), or restarts the level when empty.
  **`AIndyTextCard`** shows one `FText` for `Duration` on Activate or player overlap, once (`bShown` SaveGame), on the world timer so pause freezes it. Why C++ widget bases: the WBPs are layout only, no graph logic.
- **`AIndyExplosiveBarrel`** explodes once at a damage threshold (the pistol already applies point damage to any actor): `ApplyRadialDamage` with falloff to enemies, player and other barrels (so they chain), hides, activates its Targets once, saves `bExploded`. Gas containers are a Blueprint child. Chain (c): a debris gate on the only way on opens on the blast that kills the guard.
- **Enemies**: two flags on `AIndyEnemyCharacter` (why: flags, not new AI classes). `bHoldPosition` (sniper): the controller never moves it; it attacks in place. `bStartsDormant` (SaveGame, reinforcements): hidden, no collision, no AI until Activate.
  Variants change only defaults: spider and scorpion from the dog, sniper from the guard with `BP_SniperAIController` (sight settings live on the controller).
- **Truck**: `BP_Truck`, an `InterpToMovement` loop with no nav influence; components only, no C++. Chain (b): the truck road is walled with unmarked walls taller than a jump. From the roof, the drop onto the road is lethal, onto the truck bed safe; the truck drives into the compound. **Chain (d)**: an existing `AIndyPushBlock` covers the tunnel mouth; the player pulls it clear.
- **Layout**: persistent `L_Babylon` plus nine *Always Loaded* sublevels, one per area ticket. Not one map: every area ticket would edit the same binary file. Not One File Per Actor or World Partition: hashed file names can't be listed in tickets. Not distance streaming: the save needs every actor loaded at a stable path.
  The persistent level holds game mode, sun and sky (Lumen, no light baking), PlayerStart and a `RecastNavMesh` with `RuntimeGeneration=Dynamic`; each sublevel brings its own `NavMeshBoundsVolume`. Why dynamic: no stored nav data, so area tickets never touch the persistent map, and open gates update the nav.

## Tickets (build order; one module each). Prerequisites: F-014 epic G-057 and the F-013 epic on `main`

C++, dependencies in brackets: 1 `Level/` activation seam, switch, gate, chain (a) world test. 2 `Player/IndyCharacter`: Interact uses a switch [1]. 3 `Combat/IndyPickup` and rules: Treasure kind. 4 `Level/` secret area and level stats [3].
5 `Level/`+`UI/` exit and end widget [4, UMG]. 6 `Level/`+`UI/` text card and widget [1, UMG]. 7 `Level/` explosive barrel [1]. 8 `AI/` hold-position and dormant flags [1].
Content: 9 enemy variant Blueprints and `BP_SniperAIController` [8]. 10 prop Blueprints: lever, crank, gate, debris, barrel, gas container, treasure, truck [1, 3, 7]. 11 `WBP_TextCard`, `WBP_LevelEnd` [5, 6]. 12 `L_Babylon` and nine empty sublevels.
Area tickets, each changing one sublevel `L_Babylon_NN_*`, all [10, 12]:
13. Ruins (brief area 1): whip swing over the ditch from the columns, climbable wall, ledges.
14. Rooftops (area 1): roof treasure, the general's card, camp with four guards [6, 11].
15. Cave (area 2): dark spider room, ledge treasures, ladder, wading trench, secret route [4, 9].
16. BarrelCave (area 3): chain (c), pursuing guards at the gates, checkpoint A.
17. Camp (area 4): medkits, decline, crouch passage, hallway guard and scorpion, chain (a), tent treasure [2, 9].
18. Compound (area 5): chain (b), checkpoint B. 19. BaseYard (area 5): three guards, sniper, gas containers [9].
20. BaseInterior (area 6): coins, niche lever that wakes the reinforcements and shows their card, chain (d) [6, 8, 9].
21. Tunnels (area 6): two-level swim with an air pocket, underwater treasure, checkpoint C, exit with `MenuLevel` set [5, 11].
22. Full run in both views, respawn at A, B and C, quit and continue, counts checked, tuning [13-21]. 23. Epic.

**user_check**: `true` on 13-23. Headless runs can't play maps; the user judges the 1:1 layout and that no chain is skippable. The rest stay `false`: C++ with tests, or Blueprints with only defaults or layout (decision 0010). Tickets 2, 8, 17 and 20 run in that order.

## What must be tested (automation tests in `Tests/`)

- **Switch and gate**: a locked switch ignores use; the lever unlocks the crank; the crank opens the gate after `UseDelay`; each fires once; `OnStateRestored` re-opens the gate.
- **Barrel**: below the threshold nothing happens; it hits an enemy inside the radius, not outside; it chains to a neighbour; Targets fire once.
- **Stats**: found and total over mixed actors; a secret counts once; a treasure is taken whole. Enemy rules: hold never moves; dormant ignores sight until activated. Exit and card: a non-player overlap is ignored; each fires once.
- **Area tickets**: `CompileAllBlueprints` reports 0 errors; a headless reload lists the actors and Targets. Required moves: whip, wall, ledge (13); ladder, wading (15); crouch (17); push (18); pull (20); swim and dive (21).

## Risks

- F-013's end-screen and chain-restore criteria can only be checked in this level. Ticket 22 checks them; the F-013 epic is reviewed on the test maps.
- `UMG`, `Slate` and `SlateCore` are not in `MyGameProject.Build.cs`: a new dependency, in `NEEDS-YOU.md`. If F-013 doesn't add it, ticket 5 does, with the `deps` label.
- The player can slide off the fast `InterpToMovement` truck: keep it slow with a wide bed, tune in 18. Dark rooms keep a dim fill light. Renaming an actor breaks the old save (one slot; accepted).
