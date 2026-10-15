---
id: T-097
kind: ticket
repo: claude-dashboard
base: epic/F-008
branch:
owner: eng-claude-dashboard
brief: F-008
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:
---
## Goal
A pure, tested model of the F-008 kingdom: the castle (the user) and whether it needs them, the main court
(team-hq sessions) and one district per project, each session as one building with a kind and a state,
workers at buildings, and mailmen including those to the castle. No geometry, no rendering (T-098, T-099).

## Acceptance
- [ ] Castle: `needsYou` is true when `state.alerts.items` is non-empty or any `state.permissions` entry has
      `status: 'pending'`, false otherwise (tests for both, and for an `expired` permission alone = false)
- [ ] Grouping: a session goes to the court when its project is `team-hq` or its name is `lead`, `designer`,
      `reviewer` / `reviewer-*` or `eng-*` (engineers run in worktrees, so their project is not `team-hq`);
      every other session goes to the district of its project. A messaged-only session (not running) keeps the
      project last seen for it while the tracker lives, else falls back to the name rule, else district `other`
- [ ] Buildings: same roster, state (`active` / `idle` with idle ms / `stopped`) and worker rules as F-007's
      `city.logic.ts`, one building per session; each has a `kind`: `hall` for `lead`, `workshop` for `eng-*`,
      `guild` for reviewer and designer, `house` for everything else
- [ ] Stable order: buildings keep their slot inside their court/district, and districts keep their order,
      while on screen; arrivals and departures don't move the others (test across successive `update` calls)
- [ ] Mailmen: as F-007's postmen (one per new message, 30 s, pairing of `out`/`in`, hand-back inside the
      building), plus one mailman from a building to the castle when a new `session:<sessionId>` alert or a new
      `pending` permission for that session appears while the tracker lives (none for items already there on
      the first `update`)
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Folder: `src/client/features/messages/`. Grow `city.logic.ts` into `kingdom.logic.ts` (rename, keep its
  tests passing in their new form); keep `feedKey` / `routeText`. The panel and `city-view.vue` may keep
  working on the old shapes through a thin adapter until T-099 replaces the view, or show a placeholder.
- Inputs: `state.sessions`, `state.messages`, `state.subagents`, `state.alerts`, `state.permissions`, `nowMs`.
  Project comes from `SessionInfo.project`. Message detection is unchanged (brief: out of scope); there is no
  "message from the user" in the data, so the castle only receives mailmen.
- Use a castle id that can't clash with a session name (e.g. a constant like `@castle`).
- No CPU measurement in this brief (user, 2026-10-15).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
