---
id: T-069
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 3
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/77
---
## Goal
The hover tooltip (`#tip`) is a Vue component with the same behaviour.

## Acceptance
- [ ] `features/tooltip/tooltip.vue` replaces `initTooltip()`: same trigger attributes, position and show/hide as `tooltip.view.ts`; tip text set as text, never HTML
- [ ] Its document listeners are added on mount and removed on unmount
- [ ] `tooltip.view.ts` deleted; component test in `tests/client/features/tooltip/` covers show, move and hide
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Not a panel: mount it on the existing `#tip` element or a wrapper; say which in the hand-off.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
PR #77: https://github.com/chrisfaber95/claude-dashboard/pull/77. `features/tooltip/tooltip.vue` replaces `tooltip.view.ts` (deleted, off `TYPE_SAFETY_LEGACY_FILES`). Mounted on a new empty wrapper `#tip-root` in `index.html` via `mountComponent`; the component renders `<div id="tip" class="tip" role="tooltip">` inside it, so skins/CSS are unchanged. Same `[data-tip]` trigger, 14px offset, 8px viewport margin; text via mustache (no v-html); document `mousemove` listener added onMounted, removed onUnmounted. Component spec covers show (text not HTML), move, hide, unmount cleanup. typecheck, lint, test (458 node + 12 component) and build pass.
Rework: merged origin/main into team/T-069 (commit 323738a, pushed to PR #77). One conflict, `eslint.config.js` `TYPE_SAFETY_LEGACY_FILES` (main had removed `popups.view.ts` and `time.ts`; T-069 removes `tooltip.view.ts`): both stale lines dropped. `app.ts` auto-merged. Typecheck, lint, test pass; CI `check` green on 323738a. GitHub showed mergeable UNKNOWN right after: re-check before merging.
Rework 2: merged origin/main (T-064, T-068) into team/T-069, merge commit 15918c4, pushed to PR #77. One conflict in `src/client/app/app.ts`: kept both `mountComponent(ProjectsPanel, 'projects')` and `mountComponent(Tooltip, 'tip-root')`; `initTooltip()` stays removed. No other changes. Local typecheck, lint, test pass (463 node + 31 component). PR is MERGEABLE; CI `check` was still pending when handed off: confirm green before merging.
Reviewer: position is applied one tick after the text render (measured after nextTick), previously synchronous. No browser run: user should hover tips in skins Classic, Co-pilot, Root, light and dark (position near pointer, flips at right edge, multi-line text, hides off tips).

## Review (reviewer writes, one line per round)
round 1: approve
- lead: round 1 approved, but PR #77 conflicts with main after T-062/T-063 merged. Rework = merge origin/main into team/T-069, resolve (keep both sides), re-run typecheck/lint/test, push. No other changes.
round 2: changes - code OK and CI green, but PR conflicts with main again (T-064 #79, T-068 #76 merged; conflict in src/client/app/app.ts). Merge origin/main into team/T-069, keep both sides, re-run checks, push; no other changes.
- lead: round 2 "changes" is a merge conflict only (T-064, T-068 landed first). Rework merges origin/main again, nothing else; round 3 reviews only that merge. The lead allows this 3rd round because it is conflict-only, and holds other merges until T-069 lands.
round 3: approve - merge-only change reviewed; code unchanged from round 1 approval, PR MERGEABLE. CI `check` was still pending at review: merge.sh must see it green.
