# Sprint summary: sprint 8 (2026-10-10, phase 2)

A planning sprint, no code merged. The user reviewed the dashboard client and chose Vue 3 + Vite, with an installable
phone/tablet app and voice control as the later goal (decision 0007). Ten tickets were written (T-049..T-058), and
another lead session added T-059 (vendor four Vue skills from `vuejs-ai/skills`). The user approved every open
ticket for now: `user_ok: true` is set on T-049..T-059.

## Shipped

None.

## Open

| Ticket | Status | Next step |
| --- | --- | --- |
| T-059 | ready | dispatch first; vendors the Vue skills that T-050 needs |
| T-049 | ready | TypeScript 6 + `.vscode` tsdk; fixes `popups.view.ts:43` |
| T-055 | ready | typed transcript lines (server `transcripts/`) |
| T-057 | ready | check stored JSON in `server/features/` (`auth`) |
| T-058 | ready | check `devices.json` (`auth`) |
| T-050 | backlog, needs T-049 + T-059 | Vite + Vue + Vitest tooling; proves whether `<template src>` is type-checked |
| T-051 | backlog, needs T-050 | typed reactive store in `client/app/` |
| T-052 | backlog, needs T-051 | limits panel = pilot Vue component; then the lead writes ~17 panel tickets |
| T-053 | backlog, needs T-050 | gzip + immutable caching for hashed files |
| T-054 | backlog, needs T-050 | lint: no `any` / `as` / `!`, shrinking legacy list |
| T-056 | backlog, needs T-055 | typed `claude/` parsing, `CLAUDE_BIN_ARGS` check (`auth`) |
| T-045 | backlog, owner user | user's approve/deny check from a paired device |

## Waiting on the user

- T-045: approve/deny check (steps in `board/backlog/T-045-verify-approve-deny.md`).
- Remove the scratch folder `N:\tmp-t044\`.
- Design session with the designer: phone/tablet app + voice (trusted LAN certificate, access away from home Wi-Fi,
  voice approval of permission requests).
- Old leftovers under `N:\worktrees\` from sprint 7 (T-036, `_scratch-T048`, T-019, T-030), if not yet removed.

## Decisions

- [0007](../decisions/0007-client-on-vue-and-vite.md): client moves to Vue 3 + Vite; typing rules (no `any`, `as`
  except `as const`, `!`; outside data arrives as `unknown`); migration one panel per ticket; component tests with
  Vitest + `@vue/test-utils` + `happy-dom`; PWA/Capacitor later.

## Metrics

No tickets merged; no engineer or reviewer runs (one T-059 run was started by mistake in another session and stopped
during setup; no worktree, branch or log). No rows added to `metrics/baseline.md`.

## Notes for next sprint

- **Check claims with the user's tools.** The user's VS Code runs TypeScript 6 and found an error CI (5.9) misses.
  The lead also had to retract two counts ("no `!`", "458 of 470 typed"). Verify before stating numbers.
- **Templates:** if T-050 finds `vue-tsc` does not type-check `<template src>` files, tell the user before T-052;
  they asked for HTML in its own files.
- **Repo skills in headless runs:** unknown whether `claude -p` lists the worktree's `.claude/skills`. The engineer
  skill now says to Read `SKILL.md` by path if not; T-059 and T-050 hand-offs report what they saw.
- **Blanket approval:** the user approved "every ticket for now" (2026-10-10). A ticket whose risk changes later
  (new `auth` scope, a new residual risk) still gets a fresh `user_ok` question.
- **Two lead sessions** edited the board this sprint (`team-hq-8a` wrote T-059). Keep one lead per sprint.

## Next sprint

1. T-059 and T-049 in parallel (skills/docs vs. TypeScript upgrade).
2. T-055, then T-057 and T-058 (server typing, independent of the client).
3. T-050 once T-049 and T-059 are done; then T-051, T-052.
4. After T-052: write the per-panel tickets from its hand-off.
