---
id: T-039
repo: claude-dashboard
owner: eng-claude-dashboard-T-039
brief:                    # none: decision 0006
depends_on: [T-038, T-034, T-037, T-046]
contracts: []
labels: [auth]            # moves auth.ts, devices.ts, claude-cli.ts, server.ts
budget_usd: 3
review_rounds: 0
user_ok: true
pr: 51
---
## Goal
Server and shared code sit in the feature folders of decision 0006, so a reader finds a server area by its folder.

## Acceptance
- [ ] Every file in `src/server/` is in `http/`, `auth/`, `claude/`, `transcripts/` or `features/` per the map
      (entry point and `config.ts` stay at the top); `src/shared/types.ts` is split per domain into
      `src/shared/types/` with an `index.ts`; server tests move to `tests/server/...` mirroring `src/`
- [ ] Pure moves: `git mv`, then only import paths change (no renames, no logic edits); the PR diff shows the
      files as renames; JSON field names and routes are unchanged
- [ ] `scripts/dev.mjs` watch paths, `npm start` / `start:lan` and the "Layout" section of `docs/architecture.md`
      match the new paths; `npm run build` and `npm start` work and the dashboard loads (state it in the PR)
- [ ] `tests/code-structure.test.ts` allowlist loses every server/shared entry that is now in place; `LEGACY_FILES` in `eslint.config.js` follows the new paths
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- Decision 0006 folder map; `tests/**/*.test.ts` already globs subfolders.
- Security-relevant files only move: auth, request guards and `claude-cli.ts` keep their content.
- Needs `user_ok` to merge (NEEDS-YOU line).

## Hand-off (engineer writes, max 300 tokens)
Server files moved with `git mv` into `auth/`, `claude/`, `transcripts/` and `features/<name>/` (`server.ts` and `config.ts` stay at the top); `src/shared/types.ts` split into `src/shared/types/` with `index.ts`; server tests moved to `tests/server/...`. Only import paths changed; routes and JSON fields are untouched. Allowlists in `tests/code-structure.test.ts` and `LEGACY_FILES` follow the new paths; docs updated.
PR: https://github.com/chrisfaber95/claude-dashboard/pull/51
Checks: typecheck, lint, test (395 pass) green; build OK; started the server and `/` and `/api/state` returned 200.
Reviewer: check the diff shows renames; auth, devices, tls, claude-cli and server.ts only have import edits; client files only had the types import path changed. Left as is: `src/server/http/` (nothing fits it yet) and `tests/helpers.ts` / `fake-claude.mjs` (not moved). The types split is a verbatim copy. PR title is `T-039: ...` per the engineer skill, not strictly Conventional Commits.

## Review (reviewer writes, one line per round)
