---
id: T-046
repo: claude-dashboard
owner: eng-claude-dashboard-T-046
brief:                    # none: user request, decision 0006
depends_on: [T-038]
contracts: []
labels: [deps]            # eslint, @eslint/js, typescript-eslint (devDependencies)
budget_usd: 3
review_rounds: 0
user_ok: true
pr: https://github.com/chrisfaber95/claude-dashboard/pull/50
---
## Goal
`npm run lint` checks the readability rules of `docs/code-style.md` automatically, locally and in CI, so names and
sizes no longer depend on the reviewer noticing.

## Acceptance
- [ ] devDependencies `eslint`, `@eslint/js` and `typescript-eslint` only (pinned with `^`, install scripts read
      and named in the PR); `eslint.config.js` (flat config) covers `src/` and `tests/`; `npm run lint` exists and
      CI job `check` runs it after typecheck
- [ ] Rules as errors, matching `docs/code-style.md`: `id-length` (min 2, exceptions `i`, `j`, `a`, `b`, `_`;
      properties not checked), `id-denylist` with the abbreviations the doc forbids (at least `fmt`, `st`, `rec`,
      `sid`, `msg`, `buf`, `el`, `cls`, `tmp`, `cfg`), `@typescript-eslint/naming-convention` (camelCase, PascalCase
      types, UPPER_CASE constants, boolean variables prefixed `is/has/should/can`), `no-nested-ternary`,
      `max-lines` 300, `max-lines-per-function` 50 (off in `tests/`), `max-depth` 4
- [ ] A `LEGACY_FILES` list in `eslint.config.js` turns only those readability rules off for today's offending
      files; the comment says it may only shrink; a fixture-based test (or `npm run lint` on a temp file) shows a
      new file with `const fmt = ...` fails
- [ ] Repo `CLAUDE.md` "Commands" lists `npm run lint` and the after-every-change line includes it;
      `docs/code-style.md` says which rules ESLint checks and which stay with review; the `dependencies` policy in
      `.claude/project-params.md` lists the three packages as user-approved (2026-10-10)
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md`

## Notes (lead)
- The user asked for ESLint on 2026-10-10 (decision 0006 updated). Still `deps`: needs `user_ok` to merge.
- No Prettier, no style/format rules, no other plugins: readability rules only, so the PR stays small.
- Cleanup tickets T-039..T-044 shrink `LEGACY_FILES` the same way as the structure-test allowlists (moves update
  its paths).

## Hand-off (engineer writes, max 300 tokens)
PR #50: https://github.com/chrisfaber95/claude-dashboard/pull/50. Added eslint, @eslint/js, typescript-eslint (no install scripts of their own; only the existing esbuild/@parcel/watcher ones), `eslint.config.js` with the readability rules as errors, `npm run lint`, CI step after typecheck. `LEGACY_FILES` (83 files) turns the rules off for today's offenders and may only shrink; `tests/lint-config.test.ts` shows a new `fmt` file fails. Docs and project-params updated. typecheck, lint, test (395) pass locally; CI not yet checked.
Reviewer: `js.configs.recommended` is deliberately not enabled (readability only), so @eslint/js is installed but unused; check the LEGACY_FILES list and the naming-convention config; the PR title is not Conventional Commits (ticket-id format).

## Review (reviewer writes, one line per round)
