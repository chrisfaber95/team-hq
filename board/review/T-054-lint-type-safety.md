---
id: T-054
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-050]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every ticket for now, 2026-10-10
pr: https://github.com/chrisfaber95/claude-dashboard/pull/72
---
## Goal
Lint stops new `any`, casts and non-null assertions from entering the code, while today's offending files are listed and the list only shrinks.

## Acceptance
- [ ] `eslint.config.js` turns on `no-explicit-any`, `no-non-null-assertion`, `consistent-type-assertions` (`assertionStyle: 'never'`; `as const` still allowed) and `explicit-module-boundary-types` for `.ts` and `.vue` files
- [ ] Files that break them today are in a `TYPE_SAFETY_LEGACY_FILES` list with the same "may only shrink" rule and test as `LEGACY_FILES`; a lint fixture proves a new file with `as` fails
- [ ] `docs/code-style.md` names the rules (decision 0007 "Typing")
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Lint config only; don't fix offending files here. Panel tickets and T-055..T-058 remove entries from the list.
- Pattern: `LEGACY_FILES` in `eslint.config.js` and `tests/lint-config.test.ts`.

## Hand-off (engineer writes, max 300 tokens)
PR #72: https://github.com/chrisfaber95/claude-dashboard/pull/72. No Review points were open on the ticket and there was no earlier PR, so this is the first implementation.

- eslint.config.js: no-explicit-any, no-non-null-assertion, consistent-type-assertions (never; as const allowed), explicit-module-boundary-types for .ts and .vue.
- TYPE_SAFETY_LEGACY_FILES: 67 files generated from today's lint output, same may-only-shrink rule; eslint.config.d.ts exports it.
- tests/lint-config.test.ts + tests/lint-fixtures/bad-types.ts: new file with as/any/!/untyped export fails, as const passes, entries must exist.
- docs/code-style.md names the rules.

Checks: typecheck, lint, npm test all green locally. Reviewer: confirm the list holds only files that fail today; no source files were fixed (per Notes).

## Review (reviewer writes, one line per round)
