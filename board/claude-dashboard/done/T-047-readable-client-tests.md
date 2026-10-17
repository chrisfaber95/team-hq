---
id: T-047
repo: claude-dashboard
owner: eng-claude-dashboard-T-047
brief:
depends_on: [T-044]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: false
pr: 56
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
PR #56 https://github.com/chrisfaber95/claude-dashboard/pull/56. Tests-only change: single-letter and denylisted names renamed to full words, `isRing`/`isCentre` booleans, one-line purpose comment atop each client suite, fake-claude.mjs delays named and else-if chain tidied. `tests/client/**` and `tests/helpers.ts` removed from `LEGACY_FILES`. `helpers.ts` export names unchanged (server tests T-048 unaffected). origin/main merged in; the `eslint.config.js` conflict was resolved by keeping both sides' removals. Typecheck, lint and tests pass: 407 tests before and after, same assertions.
Reviewer: compare per-file `test(`/`assert.` counts against main, and check the merged `LEGACY_FILES`. `tests/measure-cpu.test.ts` is still listed (not client, not server).

## Review (reviewer writes, one line per round)
round 1: approve - per-file test/assert counts identical to main in all 17 client files; origin/main merged, `LEGACY_FILES` has no client or helpers entries (only measure-cpu and server); CI `check` was still running at review time, merge.sh must gate on it going green.
