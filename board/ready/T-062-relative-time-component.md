---
id: T-062
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
One shared Vue component shows a relative time ("3m ago", "in 2h", uptime), so panels stop repeating the `data-time` span by hand.

## Acceptance
- [ ] `src/client/shared/relative-time.vue` renders the same `<span data-time data-ms>` as `timeSpan()` in `shared/time.ts` for the kinds `ago`, `until`, `up`, so `tickTimes()` keeps advancing it
- [ ] The limits panel uses it instead of its hand-written spans; its component test still passes
- [ ] A component test covers each kind and a `null` time
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `timeSpan()` stays until the last string-built caller is gone (T-087 deletes it).
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
