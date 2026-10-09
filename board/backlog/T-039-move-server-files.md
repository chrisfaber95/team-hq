---
id: T-039
repo: claude-dashboard
owner: eng-claude-dashboard-T-039
brief:                    # none: decision 0006
depends_on: [T-038, T-034, T-037]
contracts: []
labels: [auth]            # moves auth.ts, devices.ts, claude-cli.ts, server.ts
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
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
- [ ] `tests/code-structure.test.ts` allowlist loses every server/shared entry that is now in place
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- Decision 0006 folder map; `tests/**/*.test.ts` already globs subfolders.
- Security-relevant files only move: auth, request guards and `claude-cli.ts` keep their content.
- Needs `user_ok` to merge (NEEDS-YOU line).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
