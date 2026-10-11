---
id: T-087
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-062, T-063, T-064, T-065, T-066, T-067, T-068, T-069, T-070, T-071, T-072, T-073, T-074, T-075, T-076, T-077, T-078, T-079, T-080, T-081, T-082, T-083, T-084]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr:
---
## Goal
One root `App.vue` replaces `app.ts`, `index.html` shrinks to a skeleton, and the string-HTML helpers are gone (decision 0007, step 4).

## Acceptance
- [ ] `src/client/app/App.vue` lays out every panel and replaces the `app.ts` render steps and `mountComponent` calls; a failing panel still must not freeze the others (`onErrorCaptured` or similar) and `#render-warn` keeps working
- [ ] `index.html` is a skeleton (head, CSP, one mount element); `patch.ts`, `shared/dom.ts`, `shared/escape.ts`, `timeSpan` and their tests deleted
- [ ] The repo `CLAUDE.md` rule "every value through `esc()`" becomes "no `v-html`"; `TYPE_SAFETY_LEGACY_FILES` has no client entries left
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Last client ticket of decision 0007. Bundle size before and after in the hand-off.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
