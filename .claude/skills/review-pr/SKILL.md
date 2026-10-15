---
name: review-pr
description: Review one ticket's pull request against its acceptance criteria and record the verdict on the board. Use when acting as the team reviewer for a ticket in team-hq/board/review/.
---

# Review a ticket's PR

You are read-only on code. You never edit the repo and send no messages: the ticket is your report.
The lead is notified when you go idle and reads your verdict from the ticket.

1. Read the ticket in `team-hq/board/review/<id>-*.md`: Goal, Acceptance, Hand-off, earlier
   `Review` lines, and `review_rounds`.
2. Read the change: `gh pr view <pr> --json title,body,baseRefName,files,statusCheckRollup` and `gh pr diff <pr>`.
   Read surrounding code with Read/Grep where the diff alone isn't enough. Run the repo's checks
   only if CI hasn't reported. The PR must target the ticket's `base:` (no `base:` means `main`);
   a PR against another branch is a `changes` reason. PRs into an `epic/*` branch get typecheck and
   lint in CI, not the tests (decision 0008): the engineer's hand-off says which tests ran.
3. Judge, in this order: does it meet every acceptance criterion; correctness bugs; security (this
   dashboard can run commands on the PC: treat auth, `server.ts` request checks and `claude-cli.ts`
   as high risk); tests cover the new behavior; it stays inside the ticket's scope; new and changed code
   follows the repo's `docs/code-style.md` (team-hq decision 0006 until it exists): file in the right
   folder, full-word names, no oversized files or functions. A clear breach in new or changed code is a
   `changes` reason; never ask to fix old code the PR doesn't touch. Ignore other style nits.
   For `.vue` changes, also read the repo's `.claude/skills/vue-best-practices/SKILL.md`; a clear breach of
   it in new code is a `changes` reason. Decision 0007 and the repo docs win where they disagree with it.
   **Epic review** (`kind: epic`, the PR epic → `main`, decision 0008): each ticket in it was already
   reviewed, so don't re-review line by line. Read the brief (`product/briefs/<brief>-*.md`) and judge
   the feature as a whole: is every acceptance criterion of the ticket (the brief's goals) met; do the
   tickets' parts fit together (calls, types and data that cross ticket boundaries, nothing left
   half-wired, no leftover TODOs or flags from an earlier ticket); does the full CI on this PR pass.
   A missing piece is a `changes` line naming it; the lead turns it into a fix ticket on the epic.
4. Record the verdict:
   - Increment `review_rounds` in the front matter.
   - Append one line under `## Review`: `round N: approve` or `round N: changes - <the 1-3 things to fix>`.
   - Post it on the PR with `gh pr review <pr> --comment -b "Team review round N: approve. <summary>"`
     (or `... changes: <numbered list>`). All sessions share one GitHub account, which can't approve
     its own PRs, so the ticket's `## Review` line is the verdict that counts; `scripts/merge.sh` reads it.
5. Move the ticket:
   - **Approve** or **changes, round 1-2**: leave it in `review/` (the lead runs `scripts/merge.sh`
     or sends the engineer back).
   - **Changes, round 3 or later**: `mv` it to `board/blocked/` and add a NEEDS-YOU line.
6. Stop. Don't message anyone; going idle is the signal.
