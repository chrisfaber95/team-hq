---
id: T-089
repo: claude-dashboard
owner: eng-claude-dashboard
brief: F-007
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 1          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr: 101
---
## Goal
A subagent hand-back in the pushed `messages` names the subagent that sent it, so the F-007 city can
run the postman from that worker to its boss inside the shop.

## Acceptance
- [ ] `MessageInfo` has an optional `agentId`; a `kind: 'subagent'` message whose transcript line carries
      `senderTaskId` gets it set to the same id `SubagentInfo.agentId` uses for that subagent; session
      messages leave it unset
- [ ] A test feeds a hand-back line with `senderTaskId` and finds a message whose `agentId` matches the
      subagent built from the same data
- [ ] `npm run typecheck` and `npm test` pass; new behavior has a test
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Server only: `src/server/transcripts/transcript-aggregates.ts` (`recordIncomingPeerMessage`) and the
  type in `src/shared/types/sessions.ts`. `subagent-index.ts` already keys hand-backs by `senderTaskId`.
- No client change; T-090 uses the field.

## Hand-off (engineer writes, max 300 tokens)
Subagent hand-back messages now carry `agentId` (= `senderTaskId`, the same id as `SubagentInfo.agentId`); session messages leave it unset. Changes: optional `agentId` on `MessageInfo` (`src/shared/types/sessions.ts`), set in `recordIncomingPeerMessage` (`transcript-aggregates.ts`). New test in `subagents-feed-and-endpoints.test.ts` matches the message agentId to the built subagent. typecheck, lint, test pass (635). PR: https://github.com/chrisfaber95/claude-dashboard/pull/101 (CI pending at hand-off). Reviewer: check the field is set only for subagent kind with senderTaskId.

## Review (reviewer writes, one line per round)
round 1: approve
