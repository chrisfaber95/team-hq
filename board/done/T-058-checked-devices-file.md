---
id: T-058
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every ticket for now, 2026-10-10
pr: 63
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
PR: https://github.com/chrisfaber95/claude-dashboard/pull/63

`loadDevices` in `src/server/auth/devices-file.ts` now parses to `unknown` and checks each entry (id, name, sha256 hex, createdMs, lastSeenMs) with type guards; no `any`, `as` or `!` left. Entries are rebuilt from the five known fields; id `pc` still rejected. Missing, corrupt or wrongly shaped file is an empty store; a bad entry is dropped, good ones kept. Beyond the criteria: duplicate ids keep only the first (security-auditor: `revoke()` removes only the first match).

Checks: typecheck, lint, 426 node tests and 2 component tests pass. security-auditor: no bypass, pollution, crash or leak.

Reviewer: look at `toStoredDevice` and the three new tests in `tests/server/auth/devices.test.ts`. Not done: id/name shape checks on load (optional hardening); dropped entries vanish silently on next save. Commit trailer uses plain "Claude" per the user's memory rule.

## Review (reviewer writes, one line per round)
round 1: approve
