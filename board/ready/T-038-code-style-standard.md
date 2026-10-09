---
id: T-038
repo: claude-dashboard
owner: eng-claude-dashboard-T-038
brief:                    # none: user request (readability), decision 0006
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The dashboard repo states how its code is organised and named, and CI catches new code that lands outside the
folder map or grows too large.

## Acceptance
- [ ] `docs/code-style.md` turns team-hq decision 0006 into an engineer's guide: folder map, naming rules (with the
      abbreviation allowlist), module and function size, comments, what a cleanup may not change; 2-3 short
      before/after examples taken from this repo (e.g. `fmt` in `app.ts`)
- [ ] Repo `CLAUDE.md`: a "Code style" entry under "Reference docs" (read before writing or changing any code), and
      the frontend/TypeScript delegation rules say to include `docs/code-style.md` in the delegation prompt
- [ ] `tests/code-structure.test.ts` fails when a `.ts` file under `src/client` or `src/server` is not in a folder
      of the map (entry points listed), or when a `src/` file passes 300 lines; today's files are in a named
      allowlist so the suite passes now, and the test says the allowlist may only shrink
- [ ] `npm run typecheck` and `npm test` pass
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Source: `N:\team-hq\decisions\0006-code-structure-and-naming.md`. Don't move or rename existing code here; that
  is T-039..T-044.
- Runs next to T-037 (`patch.ts`, popups) and T-034: only touch `docs/`, `CLAUDE.md` and the new test.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
