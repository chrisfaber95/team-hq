---
id: T-043
repo: claude-dashboard
owner: eng-claude-dashboard-T-043
brief:                    # none: decision 0006
depends_on: [T-040]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The client shell (`app/`), `shared/` and the largest features (`building`, `controls`) read like senior code, with
`app.ts` reduced to wiring.

## Acceptance
- [ ] `app.ts` renders nothing itself: the projects, sessions, usage, limits and messages sections move to their
      own feature folders; `building` and `controls` are split so no file passes 300 lines
- [ ] Names, ternaries, constants and doc comments per decision 0006 in these files (e.g. `fmt` ->
      `formatTokenCount`, `tip` -> `tooltip`)
- [ ] Behaviour unchanged: same markup and classes, `esc()` on every interpolated value, tooltips still via
      `textContent`; existing tests pass with only import and name updates; the dashboard renders in every skin
- [ ] Their entries are gone from the `tests/code-structure.test.ts` allowlist and from `LEGACY_FILES` in `eslint.config.js`; `npm run lint` passes
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- Client lane: can run in parallel with T-041/T-042 (server lane). Keep `src/shared/types` field names unchanged.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
