---
id: T-047
repo: claude-dashboard
owner: eng-claude-dashboard-T-047
brief:
depends_on: [T-044]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The client tests and shared test helpers read like the code they test, so the readability rules hold for tests too.

## Acceptance
- [ ] `tests/client/**`, `tests/helpers*` and the fake CLI follow `docs/code-style.md` (decision 0006): full-word
      names, no nested ternaries, named constants, a one-line purpose per suite
- [ ] Tests check the same things as before: same number of tests, same assertions; only names and structure change
- [ ] Their entries are gone from `LEGACY_FILES` in `eslint.config.js` (and any structure allowlist); `npm run lint`
      passes
- [ ] `npm run typecheck` and `npm test` pass; new and changed code follows `docs/code-style.md`

## Notes (lead)
Split from T-044 (blocked: `LEGACY_FILES` held 1038 errors, 515 of them in `tests/`). `max-lines-per-function` is
off for `tests/` (T-046). Server tests are T-048.
Runs in parallel with T-041 (server), which also edits `LEGACY_FILES`: before handing off, merge `origin/main` and
resolve any `eslint.config.js` conflict (keep both sides' removals).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
