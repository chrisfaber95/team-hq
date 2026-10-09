---
id: T-041
repo: claude-dashboard
owner: eng-claude-dashboard-T-041
brief:                    # none: decision 0006
depends_on: [T-040]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The server's data side (`transcripts/` and `features/`: alerts, audit-log, team, limits, settings, launch) reads
like senior code: full-word names, small functions, no file over 300 lines.

## Acceptance
- [ ] In these folders: no names outside the decision 0006 allowlist, no nested ternaries, magic numbers named,
      exported functions have a one-line doc comment; `transcripts.ts` is split (scanner, aggregates, subagent index)
- [ ] Behaviour unchanged: JSON field names, routes and file formats untouched; existing tests pass with only
      import and name updates
- [ ] Their entries are gone from the `tests/code-structure.test.ts` allowlist
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- Not in scope: `http/`, `auth/`, `claude/` (T-042). The OAuth token rules for `limits.ts` in repo `CLAUDE.md` stay.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
