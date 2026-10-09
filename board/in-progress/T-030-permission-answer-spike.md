---
id: T-030
repo: claude-dashboard
owner: eng-claude-dashboard-T-030
brief: F-005
depends_on: []
contracts: []
labels: []
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
Find out, on the installed Claude CLI, whether and how the dashboard can see and answer a background (`--bg`)
session's permission prompt, so the lead can decide F-005's design. A spike: the output is a findings document, not
product code.

## Acceptance
- [ ] `docs/spikes/permission-answer.md` answers, each with the exact command/config used and the observed result on
      CLI `2.1.295`: (1) does a `PermissionRequest` hook (or another hook) fire for a `--bg` session's prompt; (2) can
      an external process hold the prompt and return allow / deny (and how long it may wait); (3) what the session
      shows while held (status in `claude agents --json`) and after allow / deny; (4) what the hook receives (tool
      name, full command or file path) and can that be passed to the dashboard
- [ ] Any other mechanism you find (`--permission-prompt-tool`, `claude attach`, agents API) is listed with one line
      on why it does or doesn't fit; a recommendation in 3-5 lines
- [ ] Experiments ran in a throwaway folder under the worktree's temp/scratch area with project-level
      `.claude/settings.json` only; nothing written to `~/.claude/settings.json` or other user config; no
      `bypassPermissions`, no `--dangerously-skip-permissions`
- [ ] The PR contains only the document (no `src/` change); `npm run typecheck` and `npm test` still pass

## Notes (lead)
Brief: `team-hq/product/briefs/F-005-terminal-free-session-control.md` (open question 1). Today the dashboard starts
and continues sessions with `claude --bg [--resume <id>] --permission-mode <mode>` (`src/server/claude-cli.ts:142,165`)
and derives "waiting" from session status (`src/server/alerts.ts:143`). `claude --help` shows no direct
"answer prompt" command; `--permission-prompts host|none` is `--print` only. Use a harmless prompt-triggering action
(e.g. a `Bash` `echo` in `default` mode) and a cheap model. If you can't start `claude --bg` from your run, move the
ticket to `blocked/` with what you tried.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
