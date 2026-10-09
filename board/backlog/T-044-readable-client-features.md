---
id: T-044
repo: claude-dashboard
owner: eng-claude-dashboard-T-044
brief:                    # none: decision 0006
depends_on: [T-043]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: false
pr:
---
## Goal
The remaining client features and skins read like senior code, and the structure test runs with an empty allowlist.

## Acceptance
- [ ] Names, ternaries, constants and doc comments per decision 0006 in chat, devices, audit, alerts, popups,
      core/mood, team, launch, settings, login, pairing and `skins/`
- [ ] Behaviour unchanged: same markup, classes and endpoints; existing tests pass with only import and name updates
- [ ] `tests/code-structure.test.ts` allowlist is empty and the test still passes; `LEGACY_FILES` in `eslint.config.js` is empty and `npm run lint` passes
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- Last cleanup ticket; F-005's UI (T-036) builds on this layout afterwards.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
