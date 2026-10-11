---
id: T-080
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-079]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
The transcript drawer (`#drawer`) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/controls/transcript-drawer.vue` replaces `drawer.view.ts`: open transcript, subagent transcript, logs, Load earlier, the message box, Esc and Close
- [ ] `openTranscript`, `openSubagentTranscript` and `openLogs` keep their signatures for callers (chat, building, sessions)
- [ ] `drawer.view.ts` deleted; component tests cover open, load earlier, a live update and close; scroll position survives pushes
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Waits for T-079 only because both are in `features/controls/` (one ticket per module at a time).
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
