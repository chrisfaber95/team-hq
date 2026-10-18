---
id: G-012
kind: ticket
repo: my-game-project
base: epic/F-010
branch:
owner: eng-my-game-project
brief: F-010
depends_on: [G-011]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr: 16
---
## Goal
A traversal state machine on the character that the climb, hang and swing moves plug into: it takes over movement, keeps free look and camera toggle working, and hands control back cleanly.

## Acceptance
- [ ] `UIndyTraversalComponent` on `AIndyCharacter` holds a mode (None, Ladder, Wall, Ledge, Swing); entering a mode suspends normal walking and gravity, leaving one restores them.
- [ ] Normal input (move, jump, crouch, roll) is routed to the active mode; look input and the view toggle keep working in every mode, and the third-person camera never clips into the wall or ledge (pull-in stays active).
- [ ] Mode changes broadcast `BlueprintAssignable` events (`OnTraversalModeChanged`); the transition rules are a pure helper with an automation test.
- [ ] Works in first and third person, with keyboard+mouse and gamepad; the view toggle works during the move without dropping it.
- [ ] Every value the ticket adds that Blueprints may tune, and every state change worth reacting to, is exposed with a `Category` (`BlueprintReadWrite` / `BlueprintCallable` / `BlueprintAssignable`), per decision 0013.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Traversal/`. This is the framework only; the four moves are G-013..G-018. A debug console command may force a mode to prove enter/exit.
- Existing pieces to reuse: speed modifiers, view blend and settings in `Source/MyGameProject/Camera/` and `Player/`.

## Hand-off (engineer writes, max 300 tokens)
PR #16 (https://github.com/chrisfaber95/my-game-project/pull/16, base epic/F-010). C++ only, no assets.
New `Source/MyGameProject/Traversal/`: `EIndyTraversalMode`, pure `FIndyTraversalRules` (CanChange: None<->any, Wall<->Ledge direct, else via None; IsTakingOver), `UIndyTraversalComponent` (EnterMode/ExitMode, `OnTraversalModeChanged`, routed `OnTraversalMove/Jump/Crouch/Roll`, console `Indy.Traversal.Force <mode>`). `AIndyCharacter` owns it and routes move/jump/crouch/roll to it while a mode is active; look, view toggle and camera boom untouched. Enter = MOVE_Flying (no gravity), exit = MOVE_Falling; refuses to enter mid-roll.
Checks: `unreal-editor.sh check` passed (build OK, 338 Blueprints, 0 errors, 0 failed to load); clang-format 18.1.8 clean. Automation tests (`MyGameProject.Traversal.Rules.*`) compile but were not run; no PIE (gamepad, first/third person, console command unverified in play).
Reviewer: input routing in IndyCharacter.cpp; whether Wall<->Ledge-only handover fits G-013..G-018. Commit trailer says Haiku 5.5, not Sonnet 5.5 (cosmetic).

## Review (reviewer writes, one line per round)
