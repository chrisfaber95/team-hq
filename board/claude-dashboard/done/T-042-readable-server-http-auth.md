---
id: T-042
repo: claude-dashboard
owner: eng-claude-dashboard-T-042
brief:                    # none: decision 0006
depends_on: [T-041]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true
pr: 57
---
## Goal
The server's `http/`, `auth/` and `claude/` code reads like senior code, and `server.ts` is split into request
guards and per-feature routes, with every security rule intact.

## Acceptance
- [ ] `server.ts` is an entry that wires `http/guards.ts` (Host, cross-site, Origin, `X-Dashboard`, path traversal,
      security headers) and per-feature route modules; no file over 300 lines
- [ ] Names, ternaries, constants and doc comments per decision 0006 in `http/`, `auth/`, `claude/`
- [ ] Behaviour unchanged: every request check in repo `CLAUDE.md` "Rules" still applies to the same requests;
      existing server, auth, lan and commands tests pass with only import and name updates; the `security-auditor`
      agent ran on the diff and its result is in the hand-off
- [ ] Their entries are gone from the `tests/code-structure.test.ts` allowlist and from `LEGACY_FILES` in `eslint.config.js`; `npm run lint` passes
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- High risk: auth, LAN mode and `claude-cli.ts`. No logic change; if a check can't move cleanly, leave it and say so.
- Needs `user_ok` to merge (NEEDS-YOU line).
- Runs in parallel with T-047 (client tests), which also edits `LEGACY_FILES`: before handing off, merge
  `origin/main` and resolve any `eslint.config.js` conflict (keep both sides' removals).

## Hand-off (engineer writes, max 300 tokens)
PR #57 https://github.com/chrisfaber95/claude-dashboard/pull/57 (commit 33bbcc7, origin/main T-047 merged; eslint.config.js conflict resolved keeping both removals).
server.ts is now a 169-line entry; guards in http/guards.ts, per-feature routes in http/routes-*.ts (all files <300 lines). auth/ split into sessions, pairings, login-limiter, loopback, devices-file; claude/ renames only. No logic change. Allowlist/LEGACY_FILES entries removed.
Checks after merge: typecheck, lint clean; npm test 407/407. security-auditor ran on the diff vs original: no regressions found (Host, cross-site, Origin, X-Dashboard, path traversal, headers, check order, hook, device mgmt, claude-cli mode allowlist/execFile, rate limits).
Reviewer: look at http/guards.ts and handler order in server.ts handle(). Notes: Identity.sid kept with 3 eslint-disable id-denylist (renaming changes shape tests read); config.ts still LEGACY (out of scope); PR title is conventional-commit form. CI check was pending at hand-off.

## Review (reviewer writes, one line per round)
round 1: approve - guard order, hook/login/pair/identify/logout/API/static order, device-manage PC-only rule and loopback check match the original; CI check was still pending at review, merge.sh must wait for green.
