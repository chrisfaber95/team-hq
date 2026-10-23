---
id: G-089
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-088]
contracts: []
labels: [assets]
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
Layout-only WBPs for HUD, start, pause, death, settings and key row.

## Acceptance
- [ ] All WBPs compile and bind to their C++ base classes
- [ ] Widget class paths are set in DefaultGame.ini
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the assets under Assets: change

## Notes (lead)
Design: decisions/0017-f013-game-shell.md. Assets: /Game/UI/WBP_Hud, WBP_Start, WBP_Pause, WBP_Death, WBP_Settings, WBP_KeyRow. Widget class paths in DefaultGame.ini. Layout only; logic in C++ bases.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)

## Blocked
No installed tool can build a widget tree, and the WBPs need one: the C++ bases have required `BindWidget` buttons, sliders and text, so empty WBPs would fail to compile.
- Python: `WidgetBlueprint.widget_tree` and `WidgetTree.root_widget` are not exposed (`get_editor_property('widget_tree')` raises "Failed to find property"). `WidgetBlueprintFactory` does create a real WBP with the right parent.
- MCP: no UMG toolset. `BlueprintTools.create` with a UserWidget parent makes a plain Blueprint, not a WidgetBlueprint, and `ObjectTools` can't read `WidgetTree`.
Question: may I add a small editor-only C++ helper (needs the UMGEditor module, a new dependency), or can the owner build the layouts in the editor against the C++ bases?
Nothing is changed in the worktree: no assets saved, no ini edit, editor stopped. Script drafted at N:/worktrees/_g089/make_wbps.py (works once a tree writer exists).
