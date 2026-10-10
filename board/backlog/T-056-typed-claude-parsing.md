---
id: T-056
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-055]
contracts: []
labels: [auth]            # claude-cli.ts
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every ticket for now, 2026-10-10
pr:
---
## Goal
`src/server/claude/` parses its inputs without `any` or casts: the session summary uses the typed transcript lines, and the `CLAUDE_BIN_ARGS` override is checked.

## Acceptance
- [ ] `session-summary.ts` uses the T-055 line type; no `any` left
- [ ] `claude-cli.ts:60` checks that `CLAUDE_BIN_ARGS` parses to a string array instead of `as string[]`; an invalid value is refused with a fixed error, never run
- [ ] Behaviour unchanged otherwise; new tests for the invalid `CLAUDE_BIN_ARGS` case
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `claude-cli.ts` stays the only command runner (`execFile` with an argument array); no other change to how commands run. Run the `security-auditor` agent.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
