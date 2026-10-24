---
id: G-089
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-088, G-093]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Six empty Widget Blueprints with the right C++ parents, class paths set; the user lays out each screen in the UMG Designer afterwards.

## Acceptance
- [ ] `/Game/UI/WBP_Hud`, `WBP_StartScreen`, `WBP_Pause`, `WBP_Death`, `WBP_Settings`, `WBP_KeyBindingRow` exist as WidgetBlueprints (created with `WidgetBlueprintFactory`), each parented to its Indy C++ base
- [ ] Widget class paths are set in DefaultGame.ini
- [ ] Every WBP compiles with an empty widget tree
- [ ] `unreal-editor.sh check` passes
- [ ] Only the assets under Assets: and DefaultGame.ini change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Assets as listed above (use the names in Acceptance). The user builds the layouts, so create the WBPs empty: no widget tree is needed because G-093 made the bindings optional. The first engineer run found no tool can write a widget tree; do not try. Set the widget class paths in DefaultGame.ini.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)

