# Sprint summary: sprint 9 (2026-10-10..11, phase 2)

The Vue plan of decision 0007 went from tickets to a working base: Vitest, TypeScript 6, Vite + Vue, a typed state
store and the first Vue panel (limits), plus the server typing tickets. The user added T-060 (Vitest first); the lead
added T-061 (one shared `isRecord`). 13 tickets merged, all in round 1. Board is empty apart from T-045.

## Shipped

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| T-060 | Vitest + `@vue/test-utils` + `happy-dom` next to `node:test` | #61 | 1 |
| T-049 | TypeScript 6, `.vscode` tsdk | #62 | 1 |
| T-058 | `devices.json` checked field by field (`auth`) | #63 | 1 |
| T-055 | typed transcript lines | #64 | 1 |
| T-059 | four vendored Vue skills from `vuejs-ai/skills` @ c9d355f | #65 | 1 |
| T-057 | stored JSON in `server/features/` checked (`auth`) | #66 | 1 |
| T-056 | typed `claude/` parsing, `CLAUDE_BIN_ARGS` check (`auth`) | #67 | 1 |
| T-050 | Vite 8 + Vue + `vue-tsc` + `eslint-plugin-vue`; esbuild/sass/copy-html gone | #68 | 1 |
| T-061 | one `isRecord` in `src/shared/guards.ts` | #69 | 1 |
| T-051 | typed reactive store + `mountComponent` in `client/app/` | #70 | 1 |
| T-054 | lint bans `any`/`as`/`!`; 67-file legacy list that only shrinks | #72 | 1 |
| T-053 | gzip + `immutable` caching for hashed assets | #71 | 1 |
| T-052 | limits panel = first Vue component and the pattern to copy | #73 | 1 |

## Open

| Ticket | Status | Next step |
| --- | --- | --- |
| T-045 | backlog, owner user | user's approve/deny check from a paired device |
| panel tickets | not written | lead writes them from T-052's hand-off ("Next panel should copy") |

## Waiting on the user

- Browser check after T-050/T-052/T-053: pages load without CSP errors; limits panel in Classic, Co-pilot, Root,
  light and dark; gzip and fast reload on a phone (NEEDS-YOU 2026-10-11).
- T-045: approve/deny check (steps in `board/backlog/T-045-verify-approve-deny.md`).
- Remove `N:\tmp-t044\` and `N:\tmp-vue-skills\`.
- Design session: phone/tablet app + voice (trusted LAN certificate, access away from home Wi-Fi, voice approvals).

## Decisions

No new decisions. Applied from [0007](../decisions/0007-client-on-vue-and-vite.md): `vue-tsc` does not type-check
`<template src>`, so templates stay inside the `.vue` file as indented HTML (user agreed 2026-10-10).

## Metrics

Engineer $7.23 and reviewer $2.12 for 13 PRs (rows in `metrics/baseline.md`). T-059 alone took 6 engineer runs on
classifier refusals; T-053 and T-054 needed a second run after the account session limit.

## Notes for next sprint

- **Agents can't write `.claude/`.** The classifier refuses copying or committing outside Markdown there, even with an
  allow rule ("Instruction Poisoning", "Self-Modification"). Vendoring skills is a user step; the user ran it via `!`.
  The clone allow rules for `vuejs-ai/skills` stay in `engineer.settings.json` (user's choice).
- **Green PRs can break `main` together.** T-053 (new `as`) and T-054 (bans `as`) each passed CI; merged back to back,
  `main` failed lint until T-052 fixed it. Merge a ticket that adds lint rules before others, or have the user enable
  "require branches to be up to date" on `main`.
- **Merge agent refusals are flaky.** T-061's merge was refused once as "Merge Without Review"; one re-run (user's
  choice) merged it. The approval lives on the board, not on GitHub.
- **Rework runs on a blocked ticket** read "the reviewer requested changes" with an empty Review; engineers coped, but
  a lead note at the top of `## Blocked` is what they actually follow.
- **Local checkout is stale:** `N:\Projects\Claude-dashboard` is on `64e1fd1` because merge.sh leaves it alone while
  graphify files are uncommitted; `git pull` it. `git worktree prune` removes the stale T-030 entry.
- Vitest/Vite are on current majors since T-050 (Vite 8, Vitest 5).

## Next sprint

1. Lead writes the per-panel tickets from T-052's hand-off, one panel each; user approves them.
2. Dispatch the smallest read-only panels first (two at a time, different `features/` folders).
3. After the user's browser check: tickets for anything it finds.
4. T-045 when the user has run the device check.
