---
id: T-085
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/80
---
## Goal
The login page is a small Vue app with the same behaviour under the same CSP.

## Acceptance
- [ ] `login.html` mounts a `features/login/` component; same form, fields, error text and redirect as `login.view.ts`
- [ ] The page loads with no CSP change and no inline script; component test covers submit and an error
- [ ] `login.view.ts` deleted
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `auth` (LAN sign-in). No server change.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
Login page is now `features/login/login-form.vue`, mounted by `login-page.ts` into `<main id="login-app">`; error texts in `login.logic.ts`; `login.view.ts` deleted. Same form, fields, texts, POST /login. No server or CSP change. PR: https://github.com/chrisfaber95/claude-dashboard/pull/80. typecheck, lint, test (463 node + 32 component) and build pass.

Reviewer, look at:
- `vite.config.ts`: `login.html` is its own second build. login.js is served before login and may not import `assets/` chunks (PUBLIC_PATHS), so Vue is bundled into it (~61 kB) and its CSS is written as `style.css`. Check this is acceptable.
- The form no longer renders without JavaScript.
- Not seen in a browser. User should check: Classic, Co-pilot, Root skins, light and dark; wrong token (?e=1), ?e=rate, ?e=pair texts; input autofocus; real LAN sign-in.

## Review (reviewer writes, one line per round)
round 1: approve
