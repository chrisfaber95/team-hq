---
id: T-005
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-001
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 1
user_ok: false
pr: 19
---
## Goal
The server works out which things need the user (waiting sessions, usage windows over a threshold, tickets in review)
and sends them as one de-duplicated alert list in `DashboardState`, so the UI can show them without guessing.

## Acceptance
- [ ] New `DashboardState.alerts: { items: Alert[]; threshold: number }` typed in `src/shared/types.ts`; `Alert` has a deterministic `id` (`session:<sessionId>`, `usage:<windowKey>`, `ticket:<T-id>`), `kind`, display text (session name / window label + utilization + `resetsAtMs` / ticket id + title) and `sinceMs`
- [ ] A live session with `status === 'waiting'`, each limit window with `utilization >= threshold`, and each ticket in `team.active.review` gives exactly one alert; it disappears on the next build once the condition is gone
- [ ] Dismissed ids (store API only, no endpoint yet) are hidden, are removed from the store when their condition is absent so a repeat alerts again, and survive a server restart via `DATA_DIR/alerts.json` (threshold too, default 80); a missing or corrupt file falls back to defaults without crashing; usage dismissals are kept while `limits.source === 'none'`
- [ ] `node:test` coverage of the derivation and store (temp `DASHBOARD_DATA_DIR`), including no duplicates across repeated builds
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
Design: `team-hq/decisions/0002-alerts-derived-on-server.md`. Suggested home: new `src/server/alerts.ts` (pure
`deriveAlerts()` + small store), called from `state.ts`. Write the file only when it changes (tmp + rename).
`DATA_DIR` (`config.ts`) also holds secrets: never serve, log or commit it, and keep `alerts.json` free of anything secret.
Open question from the brief: does a session's `status` become `waiting` on a permission prompt? If you can check
cheaply against a real `~/.claude/sessions/<pid>.json` (read-only), record the answer in `docs/architecture.md` →
Data sources and in the hand-off; otherwise say "not checked".
Update `docs/architecture.md` → Layout for the new module.

## Hand-off (engineer writes, max 300 tokens)
Added src/server/alerts.ts: pure deriveAlerts() plus a store (dismissed ids + threshold, DATA_DIR/alerts.json, written only on change via tmp+rename, defaults on missing/corrupt file). state.ts fills DashboardState.alerts; types in src/shared/types.ts. No endpoints yet. PR: https://github.com/chrisfaber95/claude-dashboard/pull/19. typecheck ok, npm test 193 pass.
Reviewer: check dismissal pruning (usage ids kept while limits.source===none), no-duplicate ids, sinceMs (session updatedAtMs, otherwise first-seen in memory, resets on restart). Open question (waiting on permission prompt?): not checked, noted in docs/architecture.md. PR title is T-005 form, not Conventional Commits.

## Review (reviewer writes, one line per round)
round 1: approve
