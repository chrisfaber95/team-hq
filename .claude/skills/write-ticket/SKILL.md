---
name: write-ticket
description: Turn a goal into one or more board tickets in team-hq (backlog or ready). Use when the lead plans work, splits a ticket, or creates a follow-up.
---

# Write a ticket

1. Pick the next id: the highest `T-NNN` across all `board/*/` folders, plus one.
2. Copy `board/TEMPLATE.md` to `board/<folder>/<id>-<short-slug>.md` and fill in:
   - `repo` (a name from the repos list in `CLAUDE.md`), `owner: eng-<repo>`.
   - `brief: F-NNN` when the ticket comes from an approved product brief; take Goal and Acceptance
     from the brief's outcome and acceptance criteria, split across tickets as needed.
   - `depends_on` for tickets that must be `done` first.
   - `labels`: `low-risk` only if it has no migration, contract change, auth, payment, secret or
     new dependency. Add `auth`, `deps`, `contract`, `migration` where they apply.
   - **Goal**: the outcome in one or two sentences.
   - **Acceptance**: 2-5 checkboxes, each observable and testable. Always include
     "`npm run typecheck` and `npm test` pass; new behavior has a test" (or the repo's equivalent)
     and "New and changed code follows `docs/code-style.md`" (decision 0006).
   - **Notes**: pointers to files or decisions, not a design essay. For a new file, name the folder
     it belongs in (decision 0006 folder map).
3. Size check: one ticket is one module (one feature folder, e.g. `src/server/http/` or
   `src/client/features/chat/`) and one kind of change (a split, a cleanup, a feature). If the Goal
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
