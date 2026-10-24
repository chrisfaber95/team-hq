---
id: G-094
kind: ticket
repo: my-game-project
base: epic/F-013
branch:
owner: eng-my-game-project
brief: F-013
depends_on: [G-093]
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
A shell widget whose Widget Blueprint has an empty tree builds a plain, usable default layout in C++, so the menus work in play before the user styles them in the UMG Designer.

## Acceptance
- [ ] Start, pause, death, settings and key binding row each build default widgets (text, buttons, sliders, key selector rows) when their `WidgetTree` root is empty
- [ ] A WBP whose tree already has widgets is left untouched: nothing is added or replaced
- [ ] The default layout is built through the same bound members the logic already uses, so buttons, sliders and key selectors behave as in G-087
- [ ] First button is focused on open; arrow, Tab and Enter navigation works
- [ ] A test builds each base with an empty tree and checks the bound members are set
- [ ] `unreal-editor.sh check` passes
- [ ] Only the files under `Source/MyGameProject/UI/` and its tests change

## Notes (lead)
User decision 2026-10-24: G-089 creates empty WBPs, the engineer-built default layout stands in until the user restyles them in the UMG Designer during the play-test. No UMGEditor module; build with `UWidgetTree::ConstructWidget` in `NativeOnInitialized`. Plain look (greybox style) is fine. HUD already has its own optional bindings; add a default for it only if it is trivial.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
