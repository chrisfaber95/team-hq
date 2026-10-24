---
id: G-090
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-089, G-094]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 1
user_check: true
user_ok: false
pr: 72
---
## Goal
L_MainMenu greybox map, GameDefaultMap, menu and new-game map config.

## Acceptance
- [ ] Game starts on the start screen
- [ ] New Game loads the first level; Quit to menu returns here
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Assets: /Game/Maps/L_MainMenu plus map settings in Config. Plain greybox background.

## Hand-off (engineer writes, max 300 tokens)
New /Game/Maps/L_MainMenu (greybox floor, wall, sun, sky light, camera; GameMode override AIndyMenuGameMode), made by a headless Python commandlet. Config: GameDefaultMap -> L_MainMenu (DefaultEngine.ini); DefaultGame.ini [IndySaveSubsystem] NewGameMap = L_Traversal (test map until F-012), MenuMap = L_MainMenu. PR https://github.com/chrisfaber95/my-game-project/pull/72 into epic/F-013. Checks: `unreal-editor.sh check` exit 0, CompileAllBlueprints 0 errors, 0 failed to load. No PIE run (headless), so the start screen, New Game and Quit to menu flow needs the user check. Reviewer: confirm L_Traversal gets AIndyGameMode (not verified) and the map holds only the listed actors.

## Review (reviewer writes, one line per round)
round 1: approve - files match Assets (L_MainMenu + 2 ini files), base epic/F-013, CI green, config keys match UIndySaveSubsystem (Config=Game) and AIndyMenuGameMode exists; L_Traversal's game mode can't be read from the LFS binary, so the user check must confirm New Game plays with AIndyGameMode.
