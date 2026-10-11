---
id: T-086
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/82
---
## Goal
The pairing confirm page is a small Vue app with the same behaviour under the same CSP.

## Acceptance
- [ ] `pair.html` mounts a `features/pair/` component; same confirm form, `POST /pair`, error text and redirect as `pair.view.ts` (T-024 flow)
- [ ] The response is read as `unknown` and checked; component test covers confirm and an error
- [ ] `pair.view.ts` deleted
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `auth` (QR pairing). No server change.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
PR #82: https://github.com/chrisfaber95/claude-dashboard/pull/82. Pair page is now `features/pair/pair-form.vue` + `pair.logic.ts` + `pair.ts`; `pair.view.ts` deleted and out of `TYPE_SAFETY_LEGACY_FILES`. Same texts, `POST /pair`, redirect; body read as unknown and checked (`{ ok: true }`). Component spec covers confirm, 429, 401/bad body, network error, invalid code.
Reviewer, look at: `pair.html` is now an empty `<main id="pair-app" data-state data-device>` (server substitution unchanged). The server serves only `/pair.js` before login, so `pair.js` is a self-contained IIFE build (`buildClassicScript` in `vite.config.ts`, shared with `boot.js`) loaded as a classic script; a module entry would have loaded a shared chunk from `/assets/` and failed. Branch is 1 commit behind main (T-069), no conflict.
User should look at (no browser here): /pair?c= in skins Classic, Co-pilot, Root, light and dark; confirm signs in and lands on /; used code shows message and no button.
Checks: typecheck, lint, npm test (466 + 33), build pass locally; CI pending.

## Review (reviewer writes, one line per round)
round 1: approve
- lead: round 1 approved, but PR #82 conflicts with main after T-085 (login page) merged. Rework = merge origin/main into team/T-086, resolve (keep both entries), re-run checks, push. No other changes. Write your note inside the Hand-off section, not under a new heading.

## Blocked
- lead: the rework run stopped on the account session limit, not on the ticket. Do the rework in the last `- lead:` line of `## Review` (merge origin/main, nothing else).
