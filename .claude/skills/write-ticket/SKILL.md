---
name: write-ticket
description: Turn a goal into one or more board tickets in team-hq (backlog or ready). Use when the lead plans work, splits a ticket, or creates a follow-up.
---

# Write a ticket

1. Pick the next id per repo (decision 0011): the repo's prefix from `budgets.json` `repoSettings`
   (`T` for claude-dashboard, `G` for my-game-project), then the highest number with that prefix across
   `board/<repo>/*/`, plus one, three digits (`T-103`, `G-001`).
2. Copy `board/TEMPLATE.md` to `board/<repo>/<folder>/<id>-<short-slug>.md` and fill in:
   - `repo` (a name from the repos list in `CLAUDE.md`), `owner: eng-<repo>`.
   - `brief: F-NNN` when the ticket comes from an approved product brief; take Goal and Acceptance
     from the brief's outcome and acceptance criteria, split across tickets as needed.
   - `depends_on` for tickets that must be `done` first.
   - `labels`: `low-risk` only if it has no migration, contract change, auth, payment, secret or
     new dependency. Add `auth`, `deps`, `contract`, `migration` where they apply.
   - **Goal**: the outcome in one or two sentences.
   - **Acceptance**: 2-5 checkboxes, each observable and testable. Always include the repo's two
     standard criteria:
     - claude-dashboard: "`npm run typecheck` and `npm test` pass; new behavior has a test" and
       "New and changed code follows `docs/code-style.md`" (decision 0006).
     - my-game-project: "`unreal-editor.sh check` passes (build and Blueprint compile)" and "Only the
       assets under Assets: change" (decisions 0009 and 0010). A ticket that changes Blueprints or other
       assets lists each one in Notes (`Assets: /Game/...`) and gets label `assets`; the user leaves those
       assets alone until it merges, because binary files can't be merged. Set `user_check: true` when the
       user asks to see the change, and on any ticket that changes Blueprint logic (the reviewer only sees
       lossy DSL text); `merge.sh` then waits for `user_ok`. Property-only asset changes don't need it.
   - **Notes**: pointers to files or decisions, not a design essay. For a new file, name the folder
     it belongs in (dashboard: decision 0006 folder map).
3. Size check: one ticket is one module (one feature folder, e.g. `src/server/http/` or
   `src/client/features/chat/`; in the game, one class or one gameplay system under `Source/`) and one kind of change (a split, a cleanup, a feature). If the Goal
   names two folders or joins two changes with "and", split it into tickets linked by `depends_on`.
   Engineers don't delegate implementation, so a ticket must fit one session's reading.
   (T-042, "split `server.ts` and clean `http/`, `auth/`, `claude/`", should have been two.)
4. Put it in `ready/` only if it is fully specified and its dependencies are done; otherwise `backlog/`.
5. If it needs a contract change, a new dependency or touches auth/secrets, add a line to
   `board/NEEDS-YOU.md` before it goes to `ready/`.

## Handing off a brief: the epic (decision 0008)

A brief's tickets build on its own branch `epic/F-NNN` and reach `main` together:
- Every ticket of the brief gets `base: epic/F-NNN`. Its typecheck/test criterion stays as is: the engineer
  runs the tests locally, even though CI on epic PRs runs only typecheck and lint.
- Add one **epic ticket** in `backlog/`: `kind: epic`, `base: main`, `branch: epic/F-NNN`, `brief: F-NNN`,
  `depends_on` all the brief's tickets, `owner: lead`. Goal: the brief's outcome. Acceptance: the brief's
  acceptance criteria, plus "full CI green on the epic PR". It is never dispatched to an engineer.
- Run `bash scripts/epic.sh open F-NNN <repo>` before the first ticket of the brief is dispatched.
- When every other ticket of the brief is in `done/`: `bash scripts/epic.sh pr <epic-id>` opens the PR epic →
  `main` and moves the epic ticket to `review/`; then `review.sh` and `merge.sh` as for any ticket. If the brief
  has `user_check: true` (only the user sets it), `merge.sh` waits for the user's `user_ok: true`.
- A gap found in the epic review becomes a normal ticket with `base: epic/F-NNN`. Its merge updates the open epic
  PR; then run `review.sh` on the epic ticket again.

Tickets without a brief (fixes, chores, tooling) keep `base: main`.
