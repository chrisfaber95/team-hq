---
id: G-094
kind: ticket
repo: my-game-project
base: epic/F-013
branch: team/G-094
owner: eng-my-game-project
brief: F-013
depends_on: [G-093]
contracts: []
labels: []
budget_usd: 3
review_rounds: 1
user_check: false
user_ok: false
pr: 71
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
Default greybox layouts for empty shell WBPs, built in C++ (PR #71, https://github.com/chrisfaber95/my-game-project/pull/71, into epic/F-013).
- New `UI/IndyDefaultLayout.{h,cpp}` helpers; start, pause, death, settings and key-row widgets override `NativeOnInitialized` and, only when `WidgetTree->RootWidget` is null, build widgets and assign the existing BindWidgetOptional members. A tree with a root is untouched.
- `UIndyKeyBindingRowWidget` is no longer Abstract; settings falls back to it when `KeyRowClass` is empty.
- HUD: no default (not trivial).
- Checks: `unreal-editor.sh check` passed (build OK, CompileAllBlueprints 0 errors / 0 failed to load); `Automation RunTests MyGameProject.UI` 10/10 incl. new `UI.DefaultLayout.*`. No PIE check done.
- Reviewer: look at NativeOnInitialized ordering vs BindWidget binding, the Abstract removal, and that the commit trailer names Haiku 5.5 instead of Sonnet 5.5.
## Review (reviewer writes, one line per round)
round 1: approve - all criteria met; empty-tree guard (root null) keeps filled WBPs untouched; NativeOnInitialized runs after BindWidget binding so assignments stick; Abstract removal is safe (settings falls back to the C++ row). Note: commit trailer says Haiku 5.5, not Sonnet 5.5 (not a blocker). No PIE check, so the layout is unseen.
