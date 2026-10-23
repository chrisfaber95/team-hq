# Engineer notes: my-game-project (Unreal Engine 5.8, decisions 0009 and 0010)

- C++ lives under `Source/`, text config in `Config/*.ini`. Style: the Unreal Engine coding standard as the
  repo `CLAUDE.md` describes it.
- dispatch.sh started your own Unreal Editor on this worktree (never the user's, on port 8000); you reach it
  through the `unreal` MCP server. How to edit assets is in the repo `CLAUDE.md` "Editing assets": Blueprint
  logic through the MCP, bulk property changes through a Python commandlet. Team rules on top of it:
  - Change only the assets listed under "Assets:" in the ticket's Notes; any other asset is blocked
    ("needs asset <path>"). Never use the `programmatic` toolset: Python in the editor runs outside your
    permission rules.
  - `call_tool` takes the toolset's full name plus the tool's short name (`describe_toolset` lists both). Save
    with `AssetTools.save_assets(asset_paths=[<package paths>])`, after `compile_blueprint`.
  - `read_graph_dsl` is lossy (it can drop an event's body): use its text to read a graph and for the PR, never
    to write a graph back. Change graphs with the node, pin and variable tools.
- Order: C++ first. After a C++ change, run `bash N:/team-hq/scripts/unreal-editor.sh check` before you touch
  Blueprints: it stops the editor, builds, compiles all Blueprints and starts the editor again (about 4 minutes).
  The Stop hook runs the same check, so run it through `test-runner` when a step is done, not after every edit.
- CI there never compiles: your local check is the only build before merge. Name it in the PR and the hand-off.
- PR body: for each changed Blueprint, its graph as DSL text, so the reviewer can read the change. A ticket
  that changes assets has label `assets`; whether the user must look before the merge is the ticket's
  `user_check`, not yours to decide.
- A new module in `*.Build.cs` or a new plugin in the `.uproject` is a new dependency: blocked, as in SKILL.md.
