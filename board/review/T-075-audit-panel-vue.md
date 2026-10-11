---
id: T-075
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-063]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: 88
---
## Goal
The Activity popup panel (audit log with device filter) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/audit/audit-panel.vue` mounted into the Activity popup: loads `/api/audit` on open, on device change and on Refresh; same rows, device options and status text
- [ ] Only the allow-listed server error strings reach the page, as today
- [ ] `audit.view.ts`, its `app.ts` wiring and the `audit` special case in `popups.view.ts` (`details.open`) deleted; component test covers load, filter and an error
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `audit.logic.ts` keeps its tests. `<details id="audit">` may become a plain section if the popup no longer needs it; say so in the hand-off.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).
- First popup panel: copy T-064 (`board/done/T-064-projects-panel-vue.md`, "Next popup panel should copy").

## Hand-off (engineer writes, max 300 tokens)
PR #88: https://github.com/chrisfaber95/claude-dashboard/pull/88. `features/audit/audit-panel.vue` mounted into `#audit` replaces `audit.view.ts`; loads on popup open (`useOpenPopup`), device change and Refresh, ignores stale responses, shows only the two allow-listed errors. `audit.view.ts`, its app.ts wiring and the popups.view.ts special case are deleted (none was in TYPE_SAFETY_LEGACY_FILES). `<details id="audit">` became a plain `<section>` with an h2 (`.audit__summary` scss lost the cursor/[open] rules). typecheck, lint, test (471 node + 63 component), build green; CI was pending at hand-off.

Reviewer / user should look at (no browser run): Activity popup in Classic, Co-pilot, Root, light and dark: heading spacing, device dropdown keeps its choices after filtering, Refresh disables while loading, prompt tooltip, error text. Test note: panels watch the shared open-popup ref, so component tests must unmount each panel.

## Review (reviewer writes, one line per round)
round 1: approve (code meets all criteria; CI `check` was still pending at review time, merge.sh must wait for green)
