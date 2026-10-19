---
id: G-022
kind: ticket
repo: my-game-project
base: main
branch:
owner: lead
brief:
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_check: false
user_ok: false
pr:
---
## Goal
`unreal-editor.sh` never leaves an Unreal Editor running after its dispatch ends, so the MCP port 8001 is free for the next run.

## Acceptance
- [x] `stop` kills every `UnrealEditor.exe` whose command line contains the current worktree path, not only the pid in the pid file.
- [x] `start` finds an editor on this worktree the same way (not by `mcp_ready` alone), so a second `start` never launches a second editor.
- [x] After `start`, `stop`, `start`, `stop` in a worktree, `tasklist` shows no `UnrealEditor.exe` for it.
- [x] Paths compare equal whether spelled `/n/worktrees/...` or `N:\worktrees\...`.

## Notes (lead)
- Edits `scripts/unreal-editor.sh` in team-hq, outside the game repo: the lead does it between sprints, no engineer dispatch.
- Causes seen: (1) `start` stores `/proc/$!/winpid`, which can be a launcher that exits while the real editor lives on ("editor exited during startup", pid file removed, editor orphaned: G-017, 2026-10-19); (2) `logs/editor-my-game-project.log` shows starts from both `/n/worktrees/...` and `N:/worktrees/...` seconds apart (dispatch and the engineer's `check`), and the pid file keeps only the last; (3) the dispatch trap does not run if the run is hard-killed.
- Find editors with `Get-CimInstance Win32_Process` filtered on name and `CommandLine`; the lead's own `taskkill` is denied, so the script's `taskkill` is what must do the work.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
