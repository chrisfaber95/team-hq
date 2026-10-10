---
id: T-049
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: []
contracts: []
labels: [deps]            # upgrades typescript 5.9 -> 6.x
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
