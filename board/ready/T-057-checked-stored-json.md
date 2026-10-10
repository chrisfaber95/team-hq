---
id: T-057
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: []
contracts: []
labels: [auth]            # limits.ts reads the OAuth token
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every ticket for now, 2026-10-10
pr:
---
## Goal
JSON that `src/server/features/` reads from disk or the network is checked before use, instead of being trusted through `any` or `as`.

## Acceptance
- [ ] `alerts.ts:76`, `settings.ts:11`, `audit-log.ts:81` and `limits.ts:53,72,84` parse to `unknown` and check with a type guard; no `any`, `as` (except `as const`) or `!` left in those files
- [ ] A corrupt or unexpected file or response behaves as a missing one does today (tests for each)
- [ ] The OAuth token rules in the repo `CLAUDE.md` still hold: read only inside `pollLive()`, never logged, returned or put in an error
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007 "Typing". Pattern: `src/client/app/state-stream.ts:14` (parse to `unknown`, then check).
- Don't open or print `~/.claude/.credentials.json` while working; tests use fixtures. Run the `security-auditor` agent.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
