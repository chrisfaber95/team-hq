# 0001: Reviewer verdict via idle notice, not a message

Date: 2026-10-08. Decided by: the user, after sprint 1.

## Context

T-004 used 4 messages (lead→eng, eng→lead, lead→reviewer, reviewer→lead) against a target of 3 per ticket.
Every route was in the design, so the target could not be met. The reviewer's message only repeated what it had
already written in the ticket's `## Review` line, which is the verdict `scripts/merge.sh` reads.

## Decision

The reviewer sends no messages. It records the verdict in the ticket (and moves it to `blocked/` after the round cap),
then stops. The lead sends the review request with `notify_when_idle: true` and reads the ticket on the idle notice.
In phase 2, `review.sh` exiting is the same signal. The target stays at 3 messages per ticket.

## Consequences

- `review-pr` skill, `reviewer` agent (SendMessage and ListAgents removed from its tools) and `CLAUDE.md` routes updated.
- An idle notice without a new `## Review` line means the reviewer stopped early or is waiting on a prompt; the lead checks it.
- A running `reviewer` session keeps its old agent prompt until restarted.
