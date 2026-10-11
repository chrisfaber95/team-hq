---
id: T-066
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-062, T-063]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/92
---
## Goal
The Session messages popup panel (message graph and list) is a Vue component with the same look and behaviour.

## Acceptance
- [ ] `features/messages/messages-panel.vue` mounted into `#comms`: the SVG graph from `buildMessageGraph()` drawn as template SVG, plus the message list with relative times (T-062)
- [ ] Derives only while the popup is open (T-063); same markup and classes as `messages.view.ts`
- [ ] `messages.view.ts` and its `app.ts` steps deleted; component test in `tests/client/features/messages/`
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `messages.logic.ts` keeps the graph maths and its `node:test` tests.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).
- First popup panel: copy T-064 (`board/done/T-064-projects-panel-vue.md`, "Next popup panel should copy").

## Hand-off (engineer writes, max 300 tokens)
PR #92: https://github.com/chrisfaber95/claude-dashboard/pull/92. `features/messages/messages-panel.vue` (mounted into `#comms`) replaces `messages.view.ts`; graph is template SVG, feed uses `RelativeTime`, same classes. It derives only while popup `comms` is open. Small pure helpers added to `messages.logic.ts`; render step and `drawPopup` branch removed from `app.ts`; legacy lint entry removed; architecture.md updated. typecheck, lint, test (471 node + 89 component), build green.

Reviewer / user should look at (no browser run): Session messages popup in skins Classic, Co-pilot, Root, light and dark: node colours, dimmed non-live nodes, edge width and hover tooltips, feed text, relative times ticking. Node fill/stroke now go through `:style` (was an inline style string). Commit trailer is plain `Claude` per the memory rule, not the model name; PR title follows the ticket-id format.

## Review (reviewer writes, one line per round)
round 1: approve
