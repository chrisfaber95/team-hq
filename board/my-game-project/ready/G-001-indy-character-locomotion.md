---
id: G-001
kind: ticket
repo: my-game-project
base: epic/F-009
branch:
owner: eng-my-game-project
brief: F-009
depends_on: []
contracts: []
labels: [deps]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
A playable C++ character, `AIndyCharacter`, with an `AIndyGameMode` that spawns it. It walks, runs and jumps with keyboard+mouse and gamepad through Enhanced Input, and feels responsive.

## Acceptance
- [ ] `AIndyCharacter` (Source/MyGameProject/Player/) and `AIndyGameMode` exist; the game mode's default pawn is the character; the Enhanced Input mapping (move, look, jump, walk modifier) is built in C++, no input assets.
- [ ] Walk, run and jump work with keyboard+mouse and with a gamepad (run is the default pace; a held walk modifier or a half-tilted stick walks).
- [ ] Responsive: movement starts within 0.1 s of input, the player steers in mid-air, a jump is still possible for 0.1 s after walking off a ledge, and a jump pressed up to 0.1 s before landing fires on landing. Both timers are tunable `UPROPERTY` values and the timer logic is a small pure helper with an automation test.
- [ ] Walk speed, run speed and jump height are tunable `UPROPERTY` values on the character (one source for both camera views).
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] No assets change (C++ only).

## Notes (lead)
- Module: `Source/MyGameProject/Player/`. Adds `EnhancedInput` to `MyGameProject.Build.cs` (label `deps`; NEEDS-YOU 2026-10-18, merge needs `user_ok`). Add no other module.
- Stock `ACharacter` movement is fine; tune acceleration for the 0.1 s start. Camera views, crouch, roll, aim and the test map are other tickets; a plain camera component on the character is enough for now.
- Pick key defaults (WASD, mouse, Space, Left Shift as walk modifier) and say so in the PR; the user tunes feel in play.
- `Content/FirstPerson` and `Content/Variant_Shooter` are template examples; do not edit them.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
