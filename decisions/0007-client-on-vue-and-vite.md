# 0007: The dashboard client moves to Vue 3 + Vite, typed end to end

Date: 2026-10-10. Decided by: the user (Vue 3 + Vite, a phone/tablet app with voice control later, sign-off on the
new dependencies), the lead (migration order and the rules below).

## Context

The user read the client and found:
- every feature is imported and loaded at startup: one 177 KB `app.js` (no minify, no code splitting; 90 KB
  minified, 32 KB gzip), with `qrcode-generator` alone at 21 KB of it;
- typing is weak where it matters: 22 `any`s in the transcript parsers, JSON from disk trusted through `as`, about
  45 `as` casts and 13 non-null `!`s on the client (`elementById` is `getElementById(id) as T`);
- VS Code (TypeScript 6.0.3) reports an error CI misses (`popups.view.ts:43`, `hidden` is `boolean | "until-found"`
  in TS 6), because the repo pins TypeScript 5.9 and the lint config has no type-safety rules;
- HTML is built as long single-line template strings and written with `innerHTML`, so safety depends on `esc()` at
  every interpolation;
- `index.html` repeats the popup block nine times, the popup labels exist twice and have drifted, and feature forms
  live in `index.html` instead of their feature folder.

The user plans to run the dashboard as an installable app on a phone or tablet, with voice control. Angular was
considered and rejected (big-bang rewrite, runtime as large as today's whole app, most of it unused); lit-html was
considered and rejected (templates stay in TypeScript, thin mobile ecosystem).

## Decision

**Stack.** Vue 3 (Composition API, `<script setup lang="ts">`) built by Vite. Vite replaces esbuild, the sass CLI
and `copy-html.mjs`; it minifies and splits code. `vue-tsc` replaces `tsc` for `npm run typecheck`. TypeScript moves
to 6.x first, and the repo pins VS Code to the workspace TypeScript (`.vscode/settings.json`), so editor and CI check
with the same version.

**Templates.** Each component's markup is normally indented HTML. The user prefers HTML in its own file, so a
component uses `<template src="./<name>.html">` **if `vue-tsc` type-checks external templates** (T-050 proves it with
a deliberate error). If it does not, the template block stays inside the `.vue` file; the lead tells the user before
any panel is migrated. No `v-html`, ever: Vue escapes text and attributes, which replaces `esc()`. Templates are
compiled at build time (runtime-only Vue), so the CSP does not change.

**Typing.** No `any`, no `as` (except `as const`), no non-null `!` in new or changed code. Values from outside the
program (JSON from disk, network or `~/.claude`, `dataset`, `event.target`) arrive as `unknown` and are checked by a
type guard; DOM elements are narrowed with `instanceof`; constant data uses `satisfies`. Exported functions declare
their return type. ESLint enforces this with a list of today's offending files that only shrinks (same pattern as
`LEGACY_FILES` in 0006).

**Migration, one panel per ticket.** The app keeps working after every PR:
1. TypeScript 6 (T-049), then Vite + Vue tooling building today's vanilla entries (T-050).
2. A typed reactive store in `src/client/app/` fed by the existing state stream (T-051); the first panel (limits)
   becomes a Vue component mounted into its section (T-052). That PR sets the pattern every later panel copies.
3. One ticket per remaining feature folder: alerts, sessions, projects, messages, usage, team, audit, devices (QR
   code loaded with `import()` only when pairing), chat, controls, permissions, core, tooltip, settings, building,
   popups (one popup shell generated from `POPUPS`, labels in one place), login and pair (`auth`). The lead writes
   them after T-052 merges, so they copy the real pattern.
4. Last: one root `App.vue` replaces `app.ts` and `index.html` shrinks to a skeleton; `patch.ts`, `dom.ts` and
   `escape.ts` are deleted.

Pure logic stays in `<feature>.logic.ts`, tested with `node:test`. A `.vue` file sits next to it in the same feature
folder; the folder map of 0006 is unchanged. Components are tested with Vitest + `@vue/test-utils` (DOM: `happy-dom`),
the setup the vendored `vue-testing-best-practices` skill assumes; `npm test` runs both runners. Component tests live
in `tests/client/features/<feature>/` next to the logic tests.

**Later, not now.** A PWA (manifest + service worker) and, if needed, a Capacitor wrapper for app stores and native
speech recognition. Both need a trusted LAN certificate first (today's is self-signed, `auth/tls.ts`); access away
from home Wi-Fi and voice approval of permission requests are product and security questions for the designer and
the user.

## What this replaces in earlier rules

- The repo `CLAUDE.md` line "vanilla TypeScript, no framework (no React, Vue or Angular)" and the rule "every
  interpolated value goes through `esc()`" become "no `v-html`" once the last panel is migrated; T-050 updates the
  repo docs.
- 0006 kept `public/` output file names stable during cleanups. Vite writes hashed chunk names; that is allowed here.

## Consequences

- New devDependencies: `vue`, `vite`, `@vitejs/plugin-vue`, `vue-tsc`, `eslint-plugin-vue` (+ `vue-eslint-parser`),
  `vitest`, `@vue/test-utils`, `happy-dom`, approved by the user on 2026-10-10 (sign-off on the Vue dependencies, then
  on every ticket). T-059 vendors four Vue skills from `vuejs-ai/skills` (Markdown only) before T-050. TypeScript 6 is an upgrade of an existing dependency and waits for its own
  `user_ok`.
- Server typing runs in parallel: T-055 (transcripts), T-056 (`claude/`, `auth`), T-057 (stored JSON in
  `features/`, `auth` because `limits.ts` reads the OAuth token), T-058 (`auth/devices-file.ts`, `auth`).
- T-053 adds gzip and long-lived caching for Vite's hashed files; T-054 adds the type-safety lint rules.
- While panels migrate, two rendering styles live side by side. Each panel ticket deletes its old view code, so the
  mix shrinks with every merge.
