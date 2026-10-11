---
id: T-053
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-050]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every ticket for now, 2026-10-10
pr: https://github.com/chrisfaber95/claude-dashboard/pull/71
---
## Goal
Static files reach the browser compressed, and Vite's hashed files are cached by the browser, so phones and tablets load the app quickly.

## Acceptance
- [ ] `.js`, `.css`, `.html` and `.svg` responses are gzip-compressed when the request accepts it (`Content-Encoding`, `Vary: Accept-Encoding`); other types and clients without gzip get the file as today
- [ ] Files with a content hash in their name get a long-lived immutable `Cache-Control`; HTML pages and unhashed files do not
- [ ] Security headers and the path-traversal guard are unchanged (existing tests pass); new behaviour has tests in `tests/server/http/`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `src/server/http/static-files.ts`. Built-in `node:zlib` only (no new dependency). Compressing once and keeping it in memory is fine; files only change on a rebuild.
- Run the `security-auditor` agent (static file handler, repo `CLAUDE.md`).

## Hand-off (engineer writes, max 300 tokens)
Note: the rework run found an empty Review section, review_rounds 0 and no earlier PR or code, so this was built as a first pass.

PR #71: https://github.com/chrisfaber95/claude-dashboard/pull/71 (commit 19e5aea, no merge).
- `static-files.ts`: `.js/.css/.html/.svg` gzipped via `node:zlib` when Accept-Encoding allows (q=0 respected), `Vary: Accept-Encoding` on those types. Gzip kept in memory (max 64 entries, checked by mtime+size).
- `/assets/<name>-<8 char hash>.<ext>` gets `Cache-Control: private, max-age=31536000, immutable`; HTML and unhashed files get none.
- `routes-login.ts` passes Accept-Encoding for `/login`.
- New `tests/server/http/static-files.test.ts` (9 tests). typecheck, lint, npm test pass.
- security-auditor ran: no critical/high; cache bound, `private` and backslash regex fixed.
Reviewer: check `private` vs `public` choice (assets are behind login) and the cache bound.

## Review (reviewer writes, one line per round)
round 1: approve
