---
id: T-050
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-049, T-059]
contracts: []
labels: [deps]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved the Vue/Vite dependencies, 2026-10-10
pr:
---
## Goal
Vite builds the client (today's vanilla entries, minified and code-split) and the repo is ready for Vue components: Vue, its type checker and its lint plugin are installed and wired in. No panel is migrated yet.

## Acceptance
- [ ] `npm run build` and `npm run dev` use Vite: same pages (`index`, `login`, `pair`) and the pre-paint `boot` script, minified output in `public/`, the app works as before; esbuild, the sass CLI script and `scripts/copy-html.mjs` are gone; assets (fonts, `skins/root` SVGs with `checkSvg`) are still copied and checked
- [ ] `npm run typecheck` runs `vue-tsc --noEmit`; a test proves it fails on a type error inside a `<template src="./x.html">` file, or the hand-off says external templates are not type-checked (the lead then decides, decision 0007 "Templates")
- [ ] `eslint-plugin-vue` lints `.vue` files with the same readability rules; the CSP and security headers in `src/server/http/guards.ts` are unchanged and the built pages load with no CSP violation
- [ ] `npm test` runs the existing `node:test` suites and Vitest (+ `@vue/test-utils`, `happy-dom`) for component tests; one sample component test proves the setup and CI runs both
- [ ] Repo docs updated: `CLAUDE.md` (commands; the "no framework" line now points to decision 0007), `docs/architecture.md` (build, layout), `docs/code-style.md` (`.vue` files, no `v-html`, the typing rules of 0007)
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Decision 0007. New devDependencies (user approved): `vue`, `vite`, `@vitejs/plugin-vue`, `vue-tsc`, `eslint-plugin-vue`, `vue-eslint-parser`, `vitest`, `@vue/test-utils`, `happy-dom`. Nothing else without asking.
- Vue skills from T-059: `vue-best-practices`, `vue-testing-best-practices`. If they are not in your skill list, Read `.claude/skills/<name>/SKILL.md`. Say in the hand-off whether the headless run listed them (open question from T-059).
- Runtime-only Vue (templates compiled at build), so no `unsafe-eval`. The server serves `public/` as today; keep a `vite build --watch` model for `dev` (no Vite dev server, no proxy).
- Vite writes hashed file names: the server's static handler must still serve them (T-053 adds caching and gzip, not this ticket).
- `qrcode-generator` stays a normal import here; the devices panel ticket lazy-loads it.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
