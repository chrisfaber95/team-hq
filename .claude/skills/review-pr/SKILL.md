---
name: review-pr
description: Review one ticket's pull request against its acceptance criteria and record the verdict on the board. Use when acting as the team reviewer for a ticket in team-hq/board/review/.
---

# Review a ticket's PR

You are read-only on code. You never edit the repo and never message the engineer.

1. Read the ticket in `team-hq/board/review/<id>-*.md`: Goal, Acceptance, Hand-off, earlier
   `Review` lines, and `review_rounds`.
2. Read the change: `gh pr view <pr> --json title,body,files,statusCheckRollup` and `gh pr diff <pr>`.
   Read surrounding code with Read/Grep where the diff alone isn't enough. Run the repo's checks
   only if CI hasn't reported.
3. Judge, in this order: does it meet every acceptance criterion; correctness bugs; security (this
   dashboard can run commands on the PC: treat auth, `server.ts` request checks and `claude-cli.ts`
   as high risk); tests cover the new behavior; it stays inside the ticket's scope.
   Ignore style nits that CI or the conventions don't require.
4. Record the verdict:
   - Increment `review_rounds` in the front matter.
   - Append one line under `## Review`: `round N: approve` or `round N: changes - <the 1-3 things to fix>`.
   - Post it on the PR with `gh pr review <pr> --comment -b "Team review round N: approve. <summary>"`
     (or `... changes: <numbered list>`). All sessions share one GitHub account, which can't approve
     its own PRs, so the ticket's `## Review` line is the verdict that counts; `scripts/merge.sh` reads it.
5. Move the ticket and report:
   - **Approve**: leave it in `review/`. Message lead: `T-042 approved, PR #88` (the lead runs
     `scripts/merge.sh`).
   - **Changes, round 1-2**: leave it in `review/`. Message lead: `T-042 changes requested, PR #88`.
   - **Changes, round 3 or later**: `mv` it to `board/blocked/` and add a NEEDS-YOU line.
     Message lead: `T-042 blocked after 2 review rounds`.
6. Stop. One message, no acknowledgements.
