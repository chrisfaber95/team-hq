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
review_rounds: 1
user_check: false
user_ok: false
pr: 70
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
PR #70 (https://github.com/chrisfaber95/my-game-project/pull/70) into epic/F-013. Six empty WidgetBlueprints in /Game/UI (WBP_Hud, WBP_StartScreen, WBP_Pause, WBP_Death, WBP_Settings, WBP_KeyBindingRow), each parented to its Indy C++ base; made with WidgetBlueprintFactory in a headless Python commandlet (BlueprintTools.create cannot make widget BPs). DefaultGame.ini: [/Script/MyGameProject.IndyPlayerController] Hud/Start/Pause/DeathWidgetClass paths. Check run: unreal-editor.sh check passed (build 0 errors; CompileAllBlueprints 0 errors, 0 failed to load, 345 ok). No PIE check (headless). Reviewer: SettingsWidgetClass (Start/Pause/Death) and KeyRowClass (WBP_Settings) are NOT set (outside acceptance); the user sets them in the Designer or a follow-up ticket. Zen DDC 507 log noise is cache only.

## Review (reviewer writes, one line per round)
round 1: approve

