# 0011: One board per repo, ticket ids numbered per repo

Date: 2026-10-17. Decided by: the user (board per repo, per-repo numbering, the dashboard keeps `T`, the game
gets `G`), the lead (the scripts below).

## Context

All tickets shared one set of stage folders and one `T-NNN` counter. With one repo that was fine (T-001..T-102 are
all claude-dashboard), but with my-game-project onboarded (decision 0009) the two repos' tickets would mix in the
same folders and the same numbering.

## Decision

**Board per repo.** `board/<repo>/{backlog,ready,in-progress,review,blocked,done}/`. `NEEDS-YOU.md`, `SPRINT.md` and
`TEMPLATE.md` stay in `board/`: one inbox and one sprint summary for all repos.

**Ids per repo.** Each repo has a prefix in `budgets.json` `repoSettings.<repo>.prefix`: `T` for claude-dashboard
(it keeps counting, next is `T-103`; nothing is renamed) and `G` for my-game-project (`G-001`). The prefix keeps an
id unique across repos, so messages, `NEEDS-YOU.md`, `logs/<id>.log`, worktree names and `team/<id>` branches need
no repo next to it. Briefs (`F-NNN`) stay global.

**Scripts.** `scripts/lib/board.sh` finds a ticket by id across all repo boards and moves it within its own.
`dispatch.sh` refuses an id without the repo's prefix and counts the per-repo cap from that repo's `in-progress/`.

## Consequences

- Each repo's work is visible on its own; a cross-repo view (what is in review anywhere) is `board/*/review/`.
- A new repo needs a prefix in `repoSettings` before its first ticket.
- The dashboard's team panel reads the flat layout and shows no tickets until T-103 teaches it the per-repo one.
- History (sprint summaries, done tickets, metrics) keeps the old flat paths in its text.
