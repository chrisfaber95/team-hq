---
id: T-058
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The device store checks `devices.json` field by field when it loads, instead of trusting it through a cast.

## Acceptance
- [ ] `src/server/auth/devices-file.ts:36` parses to `unknown`; each device entry is checked (id, name, token hash, timestamps) and a bad entry is dropped; no `any`, `as` (except `as const`) or `!` left in the file
- [ ] A missing or corrupt file is still an empty store; a file with one bad entry keeps the good ones (tests for both)
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007 "Typing". `.dashboard/` holds secrets: never print the file; tests use their own temp data dir. Run the `security-auditor` agent.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
