---
id: T-040
repo: claude-dashboard
owner: eng-claude-dashboard-T-040
brief:                    # none: decision 0006
depends_on: [T-039]
contracts: []
labels: [auth]            # moves login.ts, pair.ts
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
Client code sits in `app/`, `features/<feature>/`, `skins/` and `shared/` per decision 0006, so everything about
one feature (view, logic, styles) is in one folder.

## Acceptance
- [ ] Every client `.ts` and feature `.scss` file is in its folder per the map (`<feature>.view.ts`,
      `<feature>.logic.ts`, `_<feature>.scss`); `util.ts` is split into `shared/` modules by purpose; client tests
      move to `tests/client/...`
- [ ] Pure moves and file renames only (`git mv`, import fixes, splitting `util.ts` without changing its functions);
      the PR diff shows the moved files as renames
- [ ] `public/` output is unchanged: still `app.js`, `login.js`, `pair.js`, `boot.js`, `style.css` and the same
      html, fonts and root files (esbuild `name=path` entries or `--outbase`); `copy-assets.mjs`, `copy-html.mjs`,
      `dev.mjs` and the Layout doc follow the new paths; `npm run build` and `npm start` work and every skin and
      popup renders (state it in the PR)
- [ ] `tests/code-structure.test.ts` allowlist loses every client entry that is now in place; `LEGACY_FILES` in `eslint.config.js` follows the new paths
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- Decision 0006 folder map. The Root skin SVGs move with `skins/`; the svg-guard and copy-assets tests must still pass.
- Needs `user_ok` to merge (login page code moves).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
