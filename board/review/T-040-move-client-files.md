---
id: T-040
repo: claude-dashboard
owner: eng-claude-dashboard-T-040
brief:                    # none: decision 0006
depends_on: [T-039]
contracts: []
labels: [auth]            # moves login.ts, pair.ts
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 52
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
round 1: changes - (1) docs/architecture.md "Test files" bullet (line ~98) still lists old paths `tests/alerts-logic.test.ts`, `chat-logic`, `chat-state`, `chat.test`, `devices-logic`, `qr`, `audit-logic`; point them at `tests/client/features/<feature>/...` (acceptance: Layout doc follows new paths). Rest is clean: renames, util split verbatim, build entries keep public/ names, typecheck + 395 tests pass locally; CI `check` was still pending. Note for user: skins/popups not browser-verified (stated in PR) and `user_ok` is set.

Moved all client `.ts`, skin scss and Root SVGs into `app/`, `features/<feature>/`, `skins/`, `shared/` with `git mv` (renames, import edits only). `util.ts` split into `shared/escape.ts`, `dom.ts`, `api.ts`, `time.ts` with functions unchanged. Client tests moved to `tests/client/...`. Build entries use esbuild `name=path`, so `public/` file names are unchanged; `copy-assets`, `dev.mjs`, `style.scss` load-css, `code-structure` allowlist (client entries gone), `LEGACY_FILES` and the docs follow the new paths.
PR: https://github.com/chrisfaber95/claude-dashboard/pull/52 (commit be17934).
Checks: typecheck, lint, `npm test` (395 pass), `npm run build` all green. Smoke run: server served `/`, app/login/pair/boot.js, style.css and a Root SVG with 200. Skins and popups were not rendered in a browser; please check.
Reviewer: confirm renames in the diff, `user_ok` needed (login.ts/pair.ts moved), `tests/helpers.ts` left in place.
