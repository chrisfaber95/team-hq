---
id: T-060
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: []
contracts: []
labels: [deps]            # vitest, @vue/test-utils, happy-dom, vue
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved the Vue/Vite dependencies, 2026-10-10 (decision 0007)
pr:
---
## Goal
Vue component tests can be written and run before any Vue code lands: `npm test` runs the existing `node:test`
suites and Vitest (`@vue/test-utils`, `happy-dom`), locally and in CI. First of the Vue tickets.

## Acceptance
- [ ] `vitest`, `@vue/test-utils`, `happy-dom` and `vue` are devDependencies (lockfile updated); a Vitest config uses
      `happy-dom` and only picks up component tests, and `node --test` no longer picks them up (each runner runs only
      its own files; the naming rule is in `docs/code-style.md`)
- [ ] One sample component test in `tests/client/` mounts a small component defined in the test with
      `defineComponent` + `h()` (no `.vue` file: SFC compiling and `vue-tsc` come with T-050), checks its rendered
      text, triggers an update and checks the new text; a failing assertion makes `npm test` exit non-zero
- [ ] `npm test` runs both runners and fails if either fails; CI (`.github/workflows/ci.yml`) needs no extra step or
      gets one, and is green
- [ ] Repo `CLAUDE.md` (commands) and `docs/code-style.md` (where component tests go, how they are named) are updated
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md`
      (decision 0006), no `any`, `as` (except `as const`) or `!`

## Notes (lead)
- Decision 0007 ("Tests": component tests in `tests/client/features/<feature>/`, Vitest + `@vue/test-utils` +
  `happy-dom`). Only the four dependencies above; nothing else without asking.
- Today `npm test` is `node --test "tests/**/*.test.ts"`, so a plain `*.test.ts` would be run by both runners.
  Pick a distinct suffix (e.g. `*.component.test.ts`) and keep the existing tests' names unchanged.
- If the vendored `vue-testing-best-practices` skill is in the repo (T-059), follow it; if not, don't wait for it.
- Also changes `package.json` and the lockfile like T-049: the lead does not run the two at the same time.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
