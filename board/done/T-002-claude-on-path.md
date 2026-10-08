---
id: T-002
repo: claude-dashboard
owner: eng-claude-dashboard
depends_on: []
contracts: []
labels: [auth]            # touches claude-cli.ts, the command surface
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 16
---
## Goal
The dashboard finds the Claude CLI on `PATH` (e.g. `~/.local/bin/claude.exe`) before falling back to
the newest VS Code extension binary, and the docs stop claiming `claude` isn't on PATH.

## Acceptance
- [x] Resolution order in `claude-cli.ts`: `CLAUDE_BIN` (+ `CLAUDE_BIN_ARGS`) → `claude`/`claude.exe` found by scanning `PATH` → newest VS Code extension binary; unchanged error when none is found
- [x] Still `execFile` with an argument array; no `shell: true`, no string-built command lines
- [x] Tests cover all three branches using a temp `PATH` dir with a fake binary (no real CLI, no network)
- [x] `docs/architecture.md` "Claude CLI behaviour" and the `CLAUDE_BIN` env var note describe the new order
- [x] `npm run typecheck` and `npm test` pass

## Notes (lead)
`src/server/claude-cli.ts:24-45` holds the current lookup. The binary on this PC is
`C:\Users\Chris\.local\bin\claude.exe` (2.1.295). Security-sensitive: run the `security-auditor` agent before handing off.

## Hand-off (engineer writes, max 300 tokens)
PR: https://github.com/chrisfaber95/claude-dashboard/pull/16 (branch `team/T-002`, commit 01951c5; CI `check` was pending at hand-off). `resolveClaudeBin()` in `src/server/claude-cli.ts` now resolves `CLAUDE_BIN` (+ `CLAUDE_BIN_ARGS`), then `claude.exe`/`claude` found by scanning `PATH` (new `claudeOnPath()`), then the newest VS Code binary. The not-found error is unchanged, and `execFile` still gets an argument array with no shell. PATH scan: strips quotes, skips relative entries, accepts only drive-letter paths on Windows (no drive-less or UNC), only native binaries (no `.cmd` shims), regular files only, and requires X_OK off Windows. New `tests/claude-bin.test.ts` (12 tests, temp dirs, binaries never run). `docs/architecture.md` updated. Locally: typecheck clean, `npm test` 167/167 passed. security-auditor and code-reviewer reported nothing blocking; their findings are fixed. Reviewer: please check the Windows drive-letter filter and the test env restore. Follow-ups (out of scope): the lookup runs synchronously on every command (no cache), and the resolved binary is not written to `commands.log`.

## Review (reviewer writes, one line per round)
round 1: approve
