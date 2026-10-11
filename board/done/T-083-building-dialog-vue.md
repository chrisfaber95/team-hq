---
id: T-083
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-082]
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/86
---
## Goal
The building dialog (open from a project, title, subtitle, close) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/building/building-dialog.vue` replaces `building.view.ts`: opens from the same triggers, title and subtitle, Close, backdrop click, Esc (not while the drawer is open), focus on Close when opened
- [ ] Clicking a cubicle or subagent still opens its transcript
- [ ] `building.view.ts` and its `app.ts` wiring deleted; component tests cover open, update, Esc order and close
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- The Esc order with popups and drawer is described in `popups.view.ts`; keep it.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
PR #86: https://github.com/chrisfaber95/claude-dashboard/pull/86 (main merged in, conflict in app.ts resolved; typecheck, lint, node tests 471 and Vitest 65 pass, build ok; CI not yet observed).
- New `building-dialog.vue` mounted into `#building-dialog`; it renders `#building` with the `hidden` attribute, so popups.view.ts checks are unchanged. `building.view.ts` and its wiring deleted; static markup removed from index.html.
- Look at: Esc order (capture listener registered after initPopups; not while drawer open), focus on Close and return to the card, closing when the project vanishes, room/cubicle click and Enter opening the transcript.
- No browser: please eyeball skins Classic, Co-pilot, Root, light and dark (DOM and classes unchanged, no SCSS change).
- Left alone: stale mentions in docs/architecture.md (chat.view.ts) and CLAUDE.md (building.view.ts example path).

## Review (reviewer writes, one line per round)
round 1: approve - all criteria met by diff reading; CI `check` was still pending at review time (merge.sh must wait for green); user should eyeball skins/themes as listed in hand-off.
