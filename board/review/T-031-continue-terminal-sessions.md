---
id: T-031
repo: claude-dashboard
owner: eng-claude-dashboard-T-031
brief: F-005
depends_on: []
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: false
pr: 42
---
## Goal
A session started in a terminal or editor can be continued from the dashboard once it has ended, and while it is still
open in a terminal the dashboard says so plainly instead of offering an action that fails.

## Acceptance
- [ ] An ended terminal/editor session (live sessions and recent sessions list) can be sent a follow-up from the
      dashboard; it continues in the background under the same session id (`claude --bg --resume`) and then shows as
      a background session
- [ ] A session still open in a live terminal or editor shows no send action; where the send form would be, the
      dashboard shows "Open in a terminal or editor; send it there, or continue here after it ends." The server keeps
      refusing with 409 (`server.ts:345`), so it never starts a copy of a running session
- [ ] Same access as today's controls: requires a signed-in device and commands enabled; `bypassPermissions` is still
      not offered or accepted
- [ ] Tests for: ended terminal session continued, live terminal session refused (409, no CLI call), no access ->
      refused; `npm run typecheck` and `npm test` pass

## Notes (lead)
Brief F-005 (story 3, AC "continued, or says clearly why it cannot"). Lead decision: no take-over of a live terminal
session; `--bg --resume` on a running session "starts a copy" (`claude --help`), which forks the conversation. Much may
already work: check what the drawer form (`src/client/controls.ts`, `drawer-form`) offers for recent and terminal
sessions and fill the gaps. `claude-cli.ts` is in scope only if `continueSession` needs a change; say so in the hand-off.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
