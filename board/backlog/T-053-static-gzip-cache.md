---
id: T-053
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007
depends_on: [T-050]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
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

## Review (reviewer writes, one line per round)
