---
id: T-002
repo: claude-dashboard
owner: eng-claude-dashboard
depends_on: []
contracts: []
labels: [auth]            # touches claude-cli.ts, the command surface
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The dashboard finds the Claude CLI on `PATH` (e.g. `~/.local/bin/claude.exe`) before falling back to
the newest VS Code extension binary, and the docs stop claiming `claude` isn't on PATH.

## Acceptance
- [ ] Resolution order in `claude-cli.ts`: `CLAUDE_BIN` (+ `CLAUDE_BIN_ARGS`) → `claude`/`claude.exe` found by scanning `PATH` → newest VS Code extension binary; unchanged error when none is found
- [ ] Still `execFile` with an argument array; no `shell: true`, no string-built command lines
- [ ] Tests cover all three branches using a temp `PATH` dir with a fake binary (no real CLI, no network)
- [ ] `docs/architecture.md` "Claude CLI behaviour" and the `CLAUDE_BIN` env var note describe the new order
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
`src/server/claude-cli.ts:24-45` holds the current lookup. The binary on this PC is
`C:\Users\Chris\.local\bin\claude.exe` (2.1.295). Security-sensitive: run the `security-auditor` agent before handing off.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
