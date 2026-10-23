# 0017: F-013 game shell (save, checkpoints, pause, HUD, settings): design and ticket split

Date: 2026-10-23. Decided by: the architect (for the planner). Brief: F-013. Repo: my-game-project. Builds on 0013 (C++ core, thin WBPs) and 0016 (F-012 waits for this epic; `IIndySaveable` is owned here).

## Decision

- **Save = one `USaveGame` slot `Checkpoint`, written by a GameInstance subsystem.** `UIndySaveSubsystem` (`Save/`) survives `OpenLevel`, so Continue, Retry and Restart all reduce to "open the saved map with a pending restore". Why not a level-reload-only reset (today's `RestartArena`): the brief needs state across a full game restart.
- **Generic state via `UPROPERTY(SaveGame)`**, not per-class save structs. `IIndySaveable` has one method, `OnStateRestored()` (re-apply visuals and collision, no gameplay broadcasts). The subsystem serializes the actor and each of its components with `FObjectAndNameAsStringProxyArchive` (`ArIsSaveGame = true`). Why: F-012 adds about eight saveable classes; each then only tags fields. Existing fields to tag: health component `Health`, `Medkits`, `bDead`; pistol `Magazine`, `Reserve`; enemy `bDead`; pickup `Amount`. Nothing is ever destroyed today (dead enemies stay, pickups hide), so no destroyed-actor list is needed.
- **Data shapes:**
  `UIndyCheckpointSave { int32 Version; FString MapPackage; FName CheckpointName; FIndyActorSaveRecord Player; TArray<FIndyActorSaveRecord> Actors; }`
  `FIndyActorSaveRecord { FString Key; FTransform Transform; TArray<uint8> ActorData; TMap<FName, FIndyComponentBlob> Components; }` (`FIndyComponentBlob { TArray<uint8> Data; }`, since a TMap value can't be a TArray in a USTRUCT).
  Key = level package name with the PIE prefix removed (`UWorld::RemovePIEPrefix`) + `:` + actor name, so PIE and standalone saves are interchangeable. The transform is applied only when the root is Movable (push blocks, enemies). The player record's transform is the checkpoint's `RespawnPoint`, not the touch-time pose (never mid-jump or mid-swim). Air is not saved (full on restore). A `Version` mismatch counts as no save.
- **Restore point**: `AIndyGameMode::StartPlay()` after `Super::StartPlay()`, so component `BeginPlay` defaults don't overwrite restored values and the Always Loaded sublevels of 0016 are present. A record whose actor is missing logs a warning and is skipped; an actor without a record stays as placed.
- **Flow functions on the subsystem**: `NewGame()` deletes the slot (why: "New Game overwrites" with no new save means Continue is hidden until the first checkpoint, and Retry before any checkpoint restarts the level, which is the brief) and opens `NewGameMap`. `Continue()` and `ReloadCheckpoint()` load and reopen with a pending restore; `ReloadCheckpoint()` without a save reopens the current map. `QuitToMenu()` opens `MenuMap`. Both maps are `Config` soft paths in `DefaultGame.ini` (a test map now; F-012 points it at `L_Babylon`).
- **`AIndyCheckpoint`** (`Save/`): a player-only trigger box plus a `RespawnPoint` arrow; `bReached` (SaveGame) makes it save once, so respawning inside it does not save again. The save is synchronous (small).
- **Death**: `AIndyGameMode` stops auto-reloading; after `RestartDelay` it broadcasts and the controller shows the death screen (Retry = `ReloadCheckpoint`).
- **Pause = `SetGamePaused(true)`**, which stops world tick, timers, physics, AI, the air meter and F-012 text cards (they use world timers). The pause key (Escape, P) lives on a new `AIndyPlayerController` in its own mapping context with `bTriggerWhenPaused`, not on the character (input is cut on death). The pause widget also handles the pause key in `NativeOnKeyDown`, because Slate focus can swallow it. Pause is ignored when dead, on the menu or at the level end.
- **Widgets**: C++ bases in `UI/` hold the logic (`BindWidget` buttons and texts); WBPs are layout only. The controller creates them from `Config` soft class paths, so no map or game-mode Blueprint changes. Keyboard and mouse: focus the first button on open; arrow, Tab and Enter navigation is native UMG. Key capture uses UMG's `UInputKeySelector`. The menu map uses `AIndyMenuGameMode` (no pawn; the controller shows the start screen).
- **HUD**: `UIndyHudWidget` replaces `AIndyDebugHUD` (its header says F-013 replaces it; delete it once no asset references it). Visibility is the pure rule `FIndyHudRules`: health always, ammo while aiming (the pistol is only out while aiming), air while `UIndyAirComponent` can't breathe. The aim crosshair moves into this widget: it belongs to aiming, it is not a stat.
- **Settings**: two subsystems, two slots (`ViewSettings`, `KeyBindings`), each saving its own data, because key bindings don't belong in a camera class and a rename would need class redirects. `UIndyViewSettings` adds `bDefaultFirstPerson` and Load/Save. Changing the default view also switches the current view, so the change shows at once. The settings screen calls Save on Back. `UIndyKeyBindings` (`Player/`) maps keyboard and mouse keys for the existing actions, with Move split into four directions. Mouse look and gamepad keys stay fixed. Binding a key that is already in use swaps the two keys (no dialogs). The character builds `IMC_Indy` from it and rebuilds on change.
- **Dependency**: `UMG`, `Slate`, `SlateCore` (approved once by the user, 2026-10-23). The first ticket that adds them (ticket 6 here) gets `deps` and needs `user_ok`, and G-062 drops its `deps` label.

## Tickets (build order; one module each)

C++: 1 `Save/` interface, save object, records, subsystem (serialize, slot IO, flow functions) [-]. 2 Saveable adoption: tag fields and `OnStateRestored` on the health, pistol, enemy, pickup and push block (one small pattern, one ticket) [1]. 3 `Save/IndyCheckpoint` and `Player/IndyGameMode` restore and death changes [1, 2].
4 `Camera/IndyViewSettings` persistence and default view [-]. 5 `Player/IndyKeyBindings` and IMC rebuild in the character [-]. 6 `UI/` HUD widget base, `FIndyHudRules`, Build.cs deps [-].
7 `UI/` menu widget bases: start, pause, death, settings with key rows [3, 4, 5, 6]. 8 `Player/IndyPlayerController` and `AIndyMenuGameMode`: pause, input modes, widget ownership, the game mode switches to them and drops the debug HUD [7].
Content: 9 WBP_Hud, WBP_StartScreen, WBP_Pause, WBP_Death, WBP_Settings, WBP_KeyBindingRow and the `DefaultGame.ini` class paths [8]. 10 `L_MainMenu` greybox, `GameDefaultMap`, menu and new-game map config [9]. 11 checkpoints in `L_CombatArena` and `L_Traversal` (enemies, pickups, push blocks) [3, 10]. 12 epic.
`user_check: true` on 10, 11 and 12 (play-tested flow); the rest are C++ with tests, or layout-only WBPs.

## Overlap with F-012 backlog

- G-058 (blocked) needs ticket 1; re-cut `epic/F-012` from `main` after the F-013 epic, as in 0016.
- G-062: Back to menu should call `UIndySaveSubsystem::QuitToMenu()` instead of its own `MenuLevel` soft world, and it drops `deps` (see above). G-068 (`WBP_LevelEnd`) stays in F-012; F-013 tickets neither the end screen nor text cards.
- F-012's new classes (G-058 switch and gate, G-061 secret, G-063 card, G-064 barrel, G-065 dormant flag) tag their fields `SaveGame` and implement `IIndySaveable`; the lead should add that line to their Notes.

## What must be tested (automation tests in `Tests/`)

- Save core (world test): capture, mutate, apply restores actor and component fields and calls `OnStateRestored` once; a missing actor is skipped; keys match with and without the PIE prefix; slot round trip on a test slot name; a version mismatch reads as no save.
- Adoption: a dead enemy stays dead with no `OnEnemyDied`; a taken pickup stays hidden; a moved push block returns to its saved spot; player health, medkits, magazine and reserve restore.
- Checkpoint: a non-player overlap is ignored; it saves once; a restored `bReached` doesn't re-save. Flow: `NewGame` deletes the slot; `ReloadCheckpoint` without a save reopens the current map.
- Rules: `FIndyHudRules` visibility; key binding swap on conflict and defaults; view settings clamp after load.

## Risks

- Restore timing: verify in a packaged build (or `-game`) that Always Loaded sublevels and the pawn exist at `StartPlay`. Ticket 3's world test covers PIE only.
- Renaming or removing a placed actor orphans its record (warning only; one slot, accepted). Keep checkpoint respawn points out of deep water (F-012 checkpoint C).
- Rebuilding the IMC with a key held can leave input stuck; rebinding happens only in menus. The chain-restore and end-screen criteria are checked only in F-012 (0016, its ticket 22).
