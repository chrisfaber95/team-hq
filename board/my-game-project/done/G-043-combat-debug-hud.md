---
id: G-043
kind: ticket
repo: my-game-project
base: epic/F-011
branch: 
owner: eng-my-game-project
brief: F-011
depends_on: [G-036, G-037, G-038]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 48
---
## Goal
Health, magazine/reserve ammo and medkit count show as simple on-screen debug text, with a crosshair while aiming.

## Acceptance
- [ ] A C++ `AHUD` (`AIndyDebugHUD`, set as `AIndyGameMode`'s HUD class) draws health, `mag / reserve` and the medkit count as plain text.
- [ ] While aiming in either view it draws a crosshair at the screen centre, where the pistol hits (G-037); an empty magazine shows a visible `EMPTY` cue.
- [ ] Values show the frame they change; nothing is drawn when the pawn is not an `AIndyCharacter`.
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: new folder `Source/MyGameProject/UI/`. Canvas drawing only (no UMG, which would be a new module; the final HUD is F-013).
- No automation test needed beyond the build; say in the hand-off how you checked it (PIE screenshot or log).

## Hand-off (engineer writes, max 300 tokens)
AIndyDebugHUD (UI/IndyDebugHUD.h/.cpp, canvas only) draws Health, Medkits and Ammo mag / reserve each frame from the pawn's health and pistol components; crosshair at screen centre while IsAiming(); red EMPTY on the ammo line and beside the crosshair at 0 rounds; nothing for non-AIndyCharacter pawns. AIndyGameMode sets HUDClass. C++ only, no assets. PR: https://github.com/chrisfaber95/my-game-project/pull/48 (into epic/F-011).
Checks: clang-format 18.1.8 clean; unreal-editor.sh check passed (build OK, CompileAllBlueprints 0 errors, 0 failed to load). No automated tests; no PIE screenshot taken, so the text layout and crosshair still need a visual PIE look. Reviewer: branch is one commit behind epic/F-011 (G-045 #47); a Blueprint game mode overriding HUD Class would win over the C++ default.

## Review (reviewer writes, one line per round)
round 1: approve
