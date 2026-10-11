---
id: T-078
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
The Chat popup panel is a Vue component with the same intents, confirm step and restrictions.

## Acceptance
- [ ] `features/chat/chat-panel.vue` covers the log, input, confirm box (Yes/No) and replies of `chat.view.ts`; the static chat markup in `index.html` moves into it
- [ ] The source guard test (`chat.view.test.ts`) checks the new file(s): still only the message, summary and alert-dismiss endpoints, never `/api/commands`, `/stop`, `/start`
- [ ] `chat.view.ts` deleted; component tests cover send with confirm, cancel, summary and an error; the log keeps its scroll position and typed input across pushes
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `chat.logic.ts` and `chat-state.logic.ts` keep their tests. Opening a transcript still calls `openTranscript` from controls.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
