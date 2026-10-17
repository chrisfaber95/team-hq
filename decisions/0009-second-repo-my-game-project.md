# 0009: Second repo my-game-project (phase 3)

Date: 2026-10-17. Decided by: the user (add the game as a team repo, C++ module, one engineer, light CI, private
GitHub repo, Git + LFS), the lead (the settings and scripts below).

## Context

`N:\Projects\MyGameProject` is a new Unreal Engine 5.8 project. The user wants the team to work on it like on the
pilot `claude-dashboard`, and to see it in the dashboard. The team's tooling assumed one Node repo: npm checks, Vue
skills, a CI that typechecks and tests. The agreed scope so far was phases 0-2; a second repo starts phase 3.

## Decision

**Repo.** `my-game-project`, private GitHub repo `chrisfaber95/my-game-project`, branch `main`. Assets
(`*.uasset`, `*.umap`, media) go through Git LFS. The game has a C++ module (`Source/MyGameProject`) next to its
Blueprints. Git work goes through the repo's own `git-workflow-manager` on the command line, as in the pilot. The
user connected the editor's Revision Control to the same Git repo; that is the user's client only (the editor's Git
provider runs the same `git.exe`, and the MCP has no commit or PR tools).

**Settings.** `budgets.json` `repoSettings.my-game-project`: prefix `G` (decision 0011), `maxParallel: 1` (one
engineer at a time, so one engineer editor), `engineerMaxMinutes: 75` (builds and editor starts take minutes), the
check command and the editor (decision 0010). `dispatch.sh` exports the check as `TEAM_CHECK`, which the engineer's
Stop hook runs.

**CI.** One light job `check` on ubuntu: the `.uproject` is valid JSON, every tracked asset is an LFS pointer, and
`clang-format` passes on `Source/`. GitHub's runners have no Unreal, so nothing compiles in CI. The real build gate
is local: `scripts/unreal-editor.sh check` (build, then compile all Blueprints) in the engineer's Stop hook.

**Live Coding off.** With Live Coding on, an open editor holds a mutex named after the engine's `UnrealEditor.exe`,
and UnrealBuildTool refuses every build of every project on that engine, worktrees included (`HotReload.cs`). The
user turned it off in their editor, and the repo sets `bEnabled=False` in
`Config/Windows/WindowsEditorPerProjectUserSettings.ini` (the engine's Windows layer overrides `Default*.ini`).

**Dashboard.** No change: it lists every folder under `N:\Projects`, so the game shows as a card.

## Consequences

- Skills have a per-repo section (engineer, review-pr, write-ticket) instead of dashboard-only rules.
- In the game, a new module in `*.Build.cs` or a new plugin in the `.uproject` counts as a new dependency.
- No contracts between the two repos; `contracts/` stays unused.
- A C++ change merged into `main` reaches the user's open editor only after a restart or an IDE build (no Live
  Coding).
