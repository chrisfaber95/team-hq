---
id: G-095
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-094]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
The Settings button on the start and pause screens opens the settings screen, and the settings screen shows its key binding rows, even though the Widget Blueprints are still empty.

## Acceptance
- [ ] `UIndyMenuWidget::OpenSettings` uses `UIndySettingsWidget` itself when `SettingsWidgetClass` is unset, so the button always opens something
- [ ] `UIndySettingsWidget` uses `UIndyKeyBindingRowWidget` itself when its row class is unset
- [ ] `DefaultGame.ini` sets both class paths to `/Game/UI/WBP_Settings` and `/Game/UI/WBP_KeyBindingRow` (the WBPs from G-089), so the user's restyled versions take over
- [ ] A test opens Settings from a menu widget with no class set and finds the settings widget in the viewport
- [ ] `unreal-editor.sh check` passes
- [ ] Only files under `Source/MyGameProject/UI/`, its tests and `Config/DefaultGame.ini` change

## Notes (lead)
Found in the G-090 play-test: Settings did nothing because `SettingsWidgetClass` is set nowhere and `OpenSettings` returns silently. Log (not silently return) if the class is truly unusable.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
