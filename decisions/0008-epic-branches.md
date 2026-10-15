# 0008: One epic branch per brief; light CI on ticket PRs

Date: 2026-10-15. Decided by: the user (epic branches, light CI per ticket, the epic gate, rollout from the next
brief), the lead (the epic ticket and the scripts below).

## Context

Every ticket PR merged straight into `main`. A brief that takes several tickets left a half-built feature on `main`
for days (F-007: T-089 and T-090 merged, T-091..T-093 not), and `merge.sh` fast-forwards the user's own checkout, so
the half-built feature showed up in the dashboard the user runs. The user's browser check of a feature (F-004)
happened only after all of it was already on `main`.

## Decision

**Epic branch.** Each brief gets a branch `epic/F-NNN`, pushed from `origin/main` by `scripts/epic.sh open` when the
brief is handed off. The brief's tickets carry `base: epic/F-NNN`: they branch from it, their PRs target it, and
`merge.sh` squash-merges them into it. Tickets without a brief (fixes, chores) keep `base: main`.

**Epic ticket.** The hand-off also creates one ticket with `kind: epic`, `base: main`, `branch: epic/F-NNN` and the
brief's goals as acceptance criteria. When all the brief's other tickets are in `done/`, `scripts/epic.sh pr` has
`git-workflow-manager` merge `main` into the epic and open the PR epic → `main`; from there the epic ticket takes the
normal route: `review.sh` (a feature review against the brief, with the `reviewer.epic` caps) and `merge.sh`.

**Epic gate.** CI green on the epic PR, the feature review approved, and, only when the brief has
`user_check: true`, the user's `user_ok: true` in the epic ticket. The epic merges with a merge commit, so `main`
keeps one commit per ticket.

**Light CI per ticket.** PRs into `epic/*` run typecheck and lint; PRs into `main` and pushes to `main` also run the
test suite. Engineers still run the tests locally (the Stop hook refuses to end a run while they fail), so the
per-ticket CI only drops a duplicate run. The user chose this over full CI per ticket.

**Rollout.** F-007 finishes on `main` as before; the next brief is the first epic.

## Consequences

- A test failure that only shows on the epic PR has no owning ticket: the lead writes a fix ticket with
  `base: epic/F-NNN`.
- Fixes merged to `main` during an epic reach the epic when `epic.sh pr` merges `main` in; a conflict there goes
  to `blocked/` and `NEEDS-YOU.md`.
- `dispatch.sh`, `merge.sh`, `review.sh`, the ticket template and the `engineer`, `review-pr` and `write-ticket`
  skills read the ticket's `base` and `kind`; claude-dashboard's `ci.yml` changes through a ticket.
