---
id: T-041
repo: claude-dashboard
owner: eng-claude-dashboard-T-041
brief:                    # none: decision 0006
depends_on: [T-040]
contracts: []
labels: [auth]            # touched features/permissions (decision 0005 hook store) beyond the ticket scope
budget_usd: 3
review_rounds: 0
user_ok: false
pr: https://github.com/chrisfaber95/claude-dashboard/pull/53
---
## Goal
The server's data side (`transcripts/` and `features/`: alerts, audit-log, team, limits, settings, launch) reads
like senior code: full-word names, small functions, no file over 300 lines.

## Acceptance
- [ ] In these folders: no names outside the decision 0006 allowlist, no nested ternaries, magic numbers named,
      exported functions have a one-line doc comment; `transcripts.ts` is split (scanner, aggregates, subagent index)
- [ ] Behaviour unchanged: JSON field names, routes and file formats untouched; existing tests pass with only
      import and name updates
- [ ] Their entries are gone from the `tests/code-structure.test.ts` allowlist and from `LEGACY_FILES` in `eslint.config.js`; `npm run lint` passes
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- Not in scope: `http/`, `auth/`, `claude/` (T-042). The OAuth token rules for `limits.ts` in repo `CLAUDE.md` stay.

## Hand-off (engineer writes, max 300 tokens)
PR #53: https://github.com/chrisfaber95/claude-dashboard/pull/53. `src/server/transcripts/*` and `src/server/features/*` renamed to full words, named constants, doc comments, no nested ternaries, functions under 50 lines. `transcripts.ts` split into `transcript-scanner.ts` (git mv), `transcript-aggregates.ts`, `subagent-index.ts`; `transcripts.ts` stays as a thin facade so imports are unchanged. `createPermissionStore` split into helpers. Entries removed from LEGACY_FILES and OVERSIZED_ALLOWLIST. Local: typecheck, lint (0 errors), 395 tests, build all pass. CI `check` was pending at hand-off. Reviewer: check behaviour is unchanged in `limits.ts` (token only read in `pollLive`) and `permissions.ts`; facade re-export is deliberate. Note: `features/permissions` was not named in the ticket but is in the folder and was in LEGACY_FILES, so it is included.

## Review (reviewer writes, one line per round)
