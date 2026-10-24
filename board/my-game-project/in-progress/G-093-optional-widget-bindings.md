---
id: G-093
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-088]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The shell widget bases (death, key binding row, pause, settings, start) work with an empty or partly laid-out Widget Blueprint, so the user can build the layouts in the UMG Designer.

## Acceptance
- [ ] Every `BindWidget` in `Source/MyGameProject/UI/` (death, key binding row, pause, settings, start) is `BindWidgetOptional`
- [ ] Every use of a bound widget is null-checked: a missing widget skips its behaviour, no crash, no log spam above `Verbose`
- [ ] A test constructs each base with no widgets bound and runs open/close (or the nearest equivalent) without error
- [ ] Existing tests still pass
- [ ] `unreal-editor.sh check` passes (build and Blueprint compile)
- [ ] Only the files under `Source/MyGameProject/UI/` and its tests change

## Notes (lead)
Why: G-089 found no tool can write a widget tree, so the user lays out the WBPs by hand; empty WBPs must compile and run (G-089 note). `IndyHudWidget` already uses `BindWidgetOptional`; follow it. Keep the widget names in the headers unchanged and add a one-line comment per widget group listing the names the user can add.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
