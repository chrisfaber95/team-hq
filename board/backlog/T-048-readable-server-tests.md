---
id: T-048
repo: claude-dashboard
owner: eng-claude-dashboard-T-048
brief:
depends_on: [T-042, T-047]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The server tests read like the code they test, and the cleanup ends with no exceptions left: both readability
allowlists are empty.

## Acceptance
- [ ] `tests/server/**` and any remaining test files follow `docs/code-style.md` (decision 0006): full-word names,
      no nested ternaries, named constants, a one-line purpose per suite
- [ ] Tests check the same things as before: same number of tests, same assertions; auth, lan and commands tests
      keep every case
- [ ] `LEGACY_FILES` in `eslint.config.js` and both allowlists in `tests/code-structure.test.ts` are empty (remove
      the lists or leave them empty with the "may only shrink" comment); `npm run lint` passes
- [ ] `npm run typecheck` and `npm test` pass; new and changed code follows `docs/code-style.md`

## Notes (lead)
Split from T-044. Last cleanup ticket: if anything outside `tests/` is still listed (a server or client file a
previous ticket missed), fix it here when small, or move this ticket to `blocked/` with the list.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
