# 0006: Dashboard code is grouped by feature and written for a reader

Date: 2026-10-09. Decided by: the user (cleanup scope, grouping by feature), the lead (the rules below).

## Context

The user read `claude-dashboard` and could not follow it: about 30 `.ts` files side by side in `src/client`, 16 in
`src/server`, 36 flat test suites; short or cryptic names (`fmt`, `tip`, `st`, `rec`, `sid`, single letters such as
`t`, `r`, `p`, `m`, `c`, `n`, `d`, `s`), nested ternaries, and modules of 400 to 540 lines (`server.ts`,
`transcripts.ts`, `app.ts`). Nothing asked for readability: tickets only checked behaviour, and the reviewer was told
to ignore style. The user wants code a senior engineer would write, for all new work and for the existing code.

## Decision

**Folder map, grouped by feature.** `tests/` mirrors `src/` (`tests/server/auth/auth.test.ts`); `tests/helpers/`
holds fixtures and the fake CLI.

```
src/
  client/
    app/                 boot.ts, app.ts (shell: wires features together), patch.ts
    features/<feature>/  <feature>.view.ts (DOM), <feature>.logic.ts (pure), _<feature>.scss
                         alerts, audit, building, chat, controls, core (+ mood), devices, launch,
                         login, pairing (+ qr), popups, settings, team, permissions, ...
    skins/               skin.ts, _copilot.scss, _root.scss, root-scene.ts, root/ (svg)
    shared/              dom helpers, formatting, api client, esc()
    style.scss, *.html, fonts/
  server/
    main.ts or server.ts (entry), config.ts
    http/                request guards, static files, routes per feature
    auth/                auth, devices, tls
    claude/              claude-cli (still the only place that runs claude.exe), session-summary
    transcripts/         scanner/aggregates, state, transcript-view
    features/            alerts, audit-log, team, limits, settings, launch, permissions, ...
  shared/types/          one file per domain + index.ts
```

**Names.**
- Full words. Allowed abbreviations only: `id`, `url`, `html`, `css`, `api`, `json`, `cli`, `tls`, `sse`, `dom`, and
  unit suffixes (`Ms`, `Bytes`, `Px`).
- Single letters only for a loop index (`i`, `j`) or a one-line comparator `(a, b) =>`.
- Booleans read as a question (`isLive`, `hasToken`, `shouldRetry`); functions start with a verb
  (`formatTokenCount`, not `fmt`); collections are plural; units are in the name (`timeoutMs`).
- Files are kebab-case and named after what they hold; no `util.ts` grab bags.

**Shape.**
- One responsibility per module. A file over ~300 lines or a function over ~50 lines is split.
- No nested ternaries; early returns over deep nesting; magic numbers become named constants.
- Exported functions and types get a one-line doc comment; other comments explain *why*, not what.
- Pure logic stays separate from DOM and I/O (the existing `*-logic.ts` pattern), so it can be tested with `node:test`.

**What does not change in a cleanup.** API routes, JSON field names in `src/shared/types`, `public/` output file
names, storage file formats, and every rule in the repo `CLAUDE.md` (security checks, `claude-cli.ts` as the only
command runner, `esc()`). Cleanups are behaviour-preserving.

**Enforcement.**
- The repo gets `docs/code-style.md` (this decision, written for engineers) and a pointer in its `CLAUDE.md`.
- `tests/code-structure.test.ts` fails on loose `.ts` files outside the folder map and on files over the size cap,
  with an allowlist for today's code that only shrinks.
- Every ticket carries "New and changed code follows `docs/code-style.md`"; the reviewer treats a breach in new or
  changed code as a `changes` reason, and never asks to fix untouched old code.
- No ESLint for now: it is a new dependency and needs the user's approval. Names are enforced in review.

## Consequences

- Cleanup tickets T-038 (standard + guard test), T-039 (move server + shared types), T-040 (move client), T-041
  (rename server data side), T-042 (rename server http/auth/claude, `auth`), T-043 (rename client shell), T-044
  (rename client features). Moves run alone; renames then run as a server lane and a client lane.
- T-039, T-040 and T-042 move or rewrite auth, login or `claude-cli.ts` code, so they carry `auth` and need `user_ok`.
- F-005 (T-035, T-036) waits for the cleanup so it is built on the new layout.
- Git history: moves use `git mv` in their own PRs with no edits besides imports, so `git log --follow` keeps working.
