---
id: T-049
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: []
contracts: []
labels: [deps]            # upgrades typescript 5.9 -> 6.x
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every ticket for now, 2026-10-10
pr: https://github.com/chrisfaber95/claude-dashboard/pull/62
---
## Goal
The repo type-checks with TypeScript 6, and VS Code uses the repo's TypeScript, so the editor and CI report the same errors.

## Acceptance
- [ ] `typescript` is `^6.0` in `package.json` and the lockfile; `typescript-eslint` is on a version that supports it
- [ ] `.vscode/settings.json` sets `"typescript.tsdk": "node_modules/typescript/lib"` and is committed
- [ ] `popups.view.ts:43` (`sectionHidden` returns `boolean | "until-found"` under TS 6) is fixed with a declared `boolean` return type, not a cast; any other TS 6 error is fixed the same way
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007. The user found the `popups.view.ts` error in VS Code (bundled TS 6.0.3); CI runs 5.9.3. The lead ran `tsc` 6.0.3 over the repo: that is the only real error.
- A local checkout without `eslint` in `node_modules` fails `tests/lint-config.test.ts`; run `npm ci` first.
- If `typescript-eslint` has no release that supports TS 6, stop and block the ticket with the versions you found.

## Hand-off (engineer writes, max 300 tokens)
PR #62: typescript ^5.9 -> ^6.0.3 (6.0.3); typescript-eslint 8.71.1 already supports <6.1.0, unchanged. Added .vscode/settings.json (typescript.tsdk). popups.view.ts: sectionHidden is `: boolean` and returns `.hidden === true` (no cast); dropped the redundant audit ternary. typecheck, lint, test (423 node:test, 2 vitest) pass locally; build not run. Reviewer: TS 7 exists on npm but typescript-eslint does not support it, so the range stays ^6.

## Review (reviewer writes, one line per round)
round 1: approve (diff meets all criteria; CI `check` was still running at review time, merge.sh must confirm it is green)
