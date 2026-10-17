# 0010: The game engineer works in its own Unreal Editor through the MCP

Date: 2026-10-17. Decided by: the user (engineers use the Unreal MCP, one engineer, asset approval only when the
ticket asks for it), the lead (own editor per worktree, the scripts and rules below).

## Context

Blueprints and other assets are binary `.uasset` files: an engineer can't write them as text, and a reviewer can't
diff them. Epic's experimental `ModelContextProtocol` plugin serves an MCP from a running editor, and its
`EditorToolset` can edit Blueprints (add nodes, connect pins, add variables, compile) and render a graph as text
(`blueprint_dsl`). Every tool goes through one MCP tool, `call_tool`, so permission rules can't tell reads from
writes. The user's own editor serves the MCP on port 8000, but on the user's checkout: changes through it would skip
the ticket branch, the PR and the review.

## Decision

**Own editor per run.** For a repo with an `editor` entry in `repoSettings`, `dispatch.sh` builds the worktree,
starts a windowless editor on it with `scripts/unreal-editor.sh start` and gives the run only that MCP server
(`--mcp-config` with `--strict-mcp-config`). A trap stops the editor however the run ends. With `maxParallel: 1`
there is one such editor, on port 8001.

**Measured** (game session, 2026-10-17):
- Flags `-unattended -nosplash -RenderOffscreen` (no `-nullrhi` needed). MCP up in about 35 s, 3.7-4.0 GB RAM.
- A relink fails while that editor holds the module DLL (LNK1104), so `check` stops the editor first
  (`stopForBuild: true`). Building a worktree while the user's editor runs on the main checkout works.
- `CompileAllBlueprints` without a window works (129 s), so `check` runs it (`compileBlueprints: true`).
- `taskkill` without `/F` doesn't stop a `-RenderOffscreen` editor; the script uses `/F /T`.
- `call_tool` takes the toolset's full name plus the tool's short name; saving is
  `AssetTools.save_assets(asset_paths=[...])`.
- `read_graph_dsl` is lossy (it dropped an event's body).

**Rules.**
- Engineers change only the assets listed under `Assets:` in the ticket. Blueprint logic goes through the MCP, bulk
  property changes through a Python commandlet (the game's `CLAUDE.md` "Editing assets").
- DSL text is for reading and for the PR only, never written back. Each changed Blueprint's DSL goes in the PR body;
  the reviewer judges from it and doesn't build or open an editor.
- The `programmatic` toolset (Python inside the editor) is forbidden by rule. Permissions can't block it, because it
  is reached through `call_tool` like every other tool; the user accepts that risk.
- Label `assets` only records that a ticket changes assets. The user approves a merge only when the ticket says so:
  `user_check: true`, which the lead sets when the user asks and on tickets that change Blueprint logic (the review
  only sees lossy DSL). `merge.sh` then waits for `user_ok: true`.
- The user leaves a ticket's listed assets alone until it merges: binary files can't be merged.

## Consequences

- A game run uses about 4 GB extra RAM and a few minutes of editor starts and checks; `engineerMaxMinutes` is 75.
- Engineer settings allow `mcp__unreal` and `unreal-editor.sh`; the Stop hook timeout is 1200 s for the UE check.
- If the experimental plugins change in a later engine version, `unreal-editor.sh` and the flags in `repoSettings`
  are the places to adjust.
