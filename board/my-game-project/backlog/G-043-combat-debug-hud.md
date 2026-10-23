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
review_rounds: 0
user_check: false
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
