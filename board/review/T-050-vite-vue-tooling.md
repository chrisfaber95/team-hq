---
id: T-050
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-049, T-059, T-060]
contracts: []
labels: [deps]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved the Vue/Vite dependencies, 2026-10-10
pr: 68
---
## Goal
Vite builds the client (today's vanilla entries, minified and code-split) and the repo is ready for Vue components: Vue, its type checker and its lint plugin are installed and wired in. No panel is migrated yet.

## Acceptance
- [ ] `npm run build` and `npm run dev` use Vite: same pages (`index`, `login`, `pair`) and the pre-paint `boot` script, minified output in `public/`, the app works as before; esbuild, the sass CLI script and `scripts/copy-html.mjs` are gone; assets (fonts, `skins/root` SVGs with `checkSvg`) are still copied and checked
- [ ] `npm run typecheck` runs `vue-tsc --noEmit`; a test proves it fails on a type error inside a `<template src="./x.html">` file, or the hand-off says external templates are not type-checked (the lead then decides, decision 0007 "Templates")
- [ ] `eslint-plugin-vue` lints `.vue` files with the same readability rules; the CSP and security headers in `src/server/http/guards.ts` are unchanged and the built pages load with no CSP violation
- [ ] The Vitest setup from T-060 also compiles `.vue` files: one sample `.vue` component test (replacing or next to the T-060 sample) passes in `npm test` and CI
- [ ] Repo docs updated: `CLAUDE.md` (commands; the "no framework" line now points to decision 0007), `docs/architecture.md` (build, layout), `docs/code-style.md` (`.vue` files, no `v-html`, the typing rules of 0007)
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007. New devDependencies (user approved): `vue`, `vite`, `@vitejs/plugin-vue`, `vue-tsc`, `eslint-plugin-vue`, `vue-eslint-parser` (`vitest`, `@vue/test-utils`, `happy-dom` and `vue` already come with T-060). Nothing else without asking.
- Vue skills from T-059 (merged; see `docs/vendored-skills.md`): load `vue-best-practices` and `vue-testing-best-practices`. T-059 found they are in a headless run's skill list when the folders exist at start; if not, Read `.claude/skills/<name>/SKILL.md`. Never write under `.claude/`: the classifier refuses it.
- Runtime-only Vue (templates compiled at build), so no `unsafe-eval`. The server serves `public/` as today; keep a `vite build --watch` model for `dev` (no Vite dev server, no proxy).
- Vite writes hashed file names: the server's static handler must still serve them (T-053 adds caching and gzip, not this ticket).
- `qrcode-generator` stays a normal import here; the devices panel ticket lazy-loads it.
- T-060 pinned `vitest` to ^3 because vitest 5 needs vite 8, whose esbuild peer clashed with our `esbuild ^0.25`. Once esbuild is gone, put `vite` and `vitest` on matching current majors (same approved packages, no new ones).

## Hand-off (engineer writes, max 300 tokens)
PR #68 (https://github.com/chrisfaber95/claude-dashboard/pull/68). Vite 8 builds the client from `vite.config.ts`; `vitest` moved to ^5 to match; esbuild, `copy-html.mjs` and the sass script are gone. `login.js`, `pair.js`, `style.css` keep their names (PUBLIC_PATHS in guards.ts); the app is `assets/index-<hash>.js`; `boot.js` is a separate import-free IIFE build. Fonts moved to `src/client/skins/fonts` so Vite leaves the `/fonts/` URLs alone. `typecheck` = vue-tsc; eslint-plugin-vue lints `.vue` with the readability rules + `no-v-html`; sample `.vue` component test replaces the h() one.

**Lead decides:** vue-tsc does NOT type-check `<template src>` files (probed: error in the .html passes, same error inline fails); docs say so.

Reviewer: no browser run was possible, so no-CSP-violation is by construction (guards.ts untouched). Expected Vite warnings: `/fonts/*` unresolved, `/boot.js` not bundled. Commit trailer names Sonnet 5.5 (session attribution), memory rule prefers plain Claude; PR title uses the T-050 prefix, not Conventional Commits.

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met; typecheck and both test runners pass locally in the worktree (CI `check` was still pending when reviewed, merge.sh must see it green); guards.ts untouched, login.js/pair.js are import-free so no hashed chunk sits behind login. Lead decision still open: `<template src>` is not type-checked by vue-tsc (documented). No browser run, so CSP is by construction.
