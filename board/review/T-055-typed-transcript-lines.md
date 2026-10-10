---
id: T-055
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every ticket for now, 2026-10-10
pr: 64
---
## Goal
The transcript parsers work on typed lines instead of `any`, so a change in Claude Code's transcript format fails a check instead of silently emptying a panel.

## Acceptance
- [ ] A transcript-line type in `src/server/transcripts/` covers the fields the parsers read; `parseLine` returns it (or `undefined`) after checking the parsed `unknown` with a type guard
- [ ] No `any`, `as` (except `as const`) or `!` left in `transcript-scanner.ts`, `transcript-view.ts`, `transcript-aggregates.ts`, `subagent-index.ts`
- [ ] Behaviour unchanged on the existing fixtures; new tests cover a line with a missing or wrong-typed field (skipped, not a crash)
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007 "Typing". The formats are in `docs/architecture.md` "Data sources"; read it first.
- Lines can be caught mid-write: an unreadable or unexpected line is skipped and retried on the next tick, never a crash (repo `CLAUDE.md`).
- `src/server/claude/session-summary.ts` also reads lines; it moves to this type in T-056, not here.

## Hand-off (engineer writes, max 300 tokens)
PR: https://github.com/chrisfaber95/claude-dashboard/pull/64 (branch team/T-055).
- New `src/server/transcripts/transcript-line.ts`: `TranscriptLine` type, `isRecord` guard, `parseTranscriptLine(raw)` (parses as `unknown`, wrong-typed fields dropped, non-object lines skipped).
- scanner, view, aggregates and subagent-index take `TranscriptLine`; no `any`/`as`/`!` left in them.
- Tests: `tests/server/transcripts/transcript-line.test.ts` (malformed lines, blocks and fields; scanner keeps counting valid lines). typecheck, lint, npm test green locally; CI pending when handed off.
- Reviewer look at: malformed-input behaviour change (tool_use without string name/id and non-string text blocks are now skipped instead of rendering "undefined"; JSON null/array lines skipped). session-summary.ts untouched (T-056).

## Review (reviewer writes, one line per round)
