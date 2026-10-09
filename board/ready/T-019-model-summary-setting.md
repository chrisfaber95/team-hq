---
id: T-019
repo: claude-dashboard
owner: eng-claude-dashboard-T-019
brief: F-003
depends_on: [T-018]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true
pr:
---
## Goal
A dashboard setting switches session summaries from the recap to one cheap-model call through the Claude CLI, for
when the user wants a real summary.

## Acceptance
- [ ] Setting `summary: 'recap' | 'model'` (default `recap`), persisted in `DATA_DIR` and changeable from the dashboard through a POST endpoint with the existing checks; shown next to the chat
- [ ] In `model` mode the summary endpoint runs one `claude -p` call with `--model haiku` through `claude-cli.ts` only: `execFile` + argument array, **no tools allowed**, no `--bg`, no session resume, transcript excerpt (max 20 KB, from the recap's source) passed as data with a fixed instruction; counts toward the 4-process cap, timeout 60 s, audited (`action: 'summary'`, device, session; no transcript text)
- [ ] On any failure or timeout it returns the recap with `mode: 'recap'` and a short fixed note; the answer is rendered as text, never HTML; tokens only, never cost
- [ ] Tests with the fake CLI (`tests/fake-claude.mjs`) for the argument array (model, no tools), fallback on error/timeout, the cap and the setting; `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0004-chat-without-a-model.md`. Touches `claude-cli.ts`, which the team counts as auth:
read the repo CLAUDE.md "Commands" rules and `docs/architecture.md` "Claude CLI behaviour (verified)" first, and
verify the no-tools flag against the real CLI (`claude --help`), recording it in that section. Never add
`bypassPermissions`/`dontAsk`. The transcript text is untrusted: keep it out of the argument list (stdin or a temp
file the CLI reads as data) so it can't become a flag. Run `security-auditor` before the PR.
T-018 (PR #33) left the seam: `summarize(path, mode)` in `src/server/session-summary.ts`; plug model mode in there and
reuse its `redact()` and tail read for the excerpt.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
