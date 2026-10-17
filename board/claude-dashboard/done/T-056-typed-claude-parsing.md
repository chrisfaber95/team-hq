---
id: T-056
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-055]
contracts: []
labels: [auth]            # claude-cli.ts
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every ticket for now, 2026-10-10
pr: https://github.com/chrisfaber95/claude-dashboard/pull/67
---
## Goal
`src/server/claude/` parses its inputs without `any` or casts: the session summary uses the typed transcript lines, and the `CLAUDE_BIN_ARGS` override is checked.

## Acceptance
- [ ] `session-summary.ts` uses the T-055 line type; no `any` left
- [ ] `claude-cli.ts:60` checks that `CLAUDE_BIN_ARGS` parses to a string array instead of `as string[]`; an invalid value is refused with a fixed error, never run
- [ ] Behaviour unchanged otherwise; new tests for the invalid `CLAUDE_BIN_ARGS` case
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- T-055 merged: `TranscriptLine`, `parseTranscriptLine` and `isRecord` are in `src/server/transcripts/transcript-line.ts`. Import them; don't write another `isRecord` (T-061 merges the copies).
- `claude-cli.ts` stays the only command runner (`execFile` with an argument array); no other change to how commands run. Run the `security-auditor` agent.

## Hand-off (engineer writes, max 300 tokens)
PR #67: https://github.com/chrisfaber95/claude-dashboard/pull/67 (commit 6a9088e).
- `session-summary.ts`: `recapSession` reads lines with `parseTranscriptLine`; no `any`; `toolAction` takes `Record<string, unknown> | undefined`.
- `claude-cli.ts`: `parseBinArgs` checks `CLAUDE_BIN_ARGS` is a JSON array of strings. Invalid: fixed 500 `CommandError`, `run()` rejects before any process starts or the counter increments.
- Tests: 7 invalid cases plus `[]` in `claude-bin.test.ts`. typecheck, lint, test pass (438 node + 2 Vitest).
- security-auditor: no Critical/High/Medium. Low: the 500 is thrown before the audit call, so no `commands.log` entry (no command ran).
- Reviewer look at: token counts now go through `numberField` (numeric strings accepted, non-string `message.id`/`requestId` treated as absent), as in T-055. Branch is one commit behind main (#66).

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met; invalid CLAUDE_BIN_ARGS refused with fixed 500 before any spawn, no `any`/casts left, 7 invalid cases tested. CI `check` was still pending at review time (merge.sh gates on it); branch is one commit behind main (#66), update before merge if needed.
