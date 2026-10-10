---
id: T-042
repo: claude-dashboard
owner: eng-claude-dashboard-T-042
brief:                    # none: decision 0006
depends_on: [T-041]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true
pr:
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

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
