---
id: T-102
kind: epic
repo: claude-dashboard
base: main
branch: epic/F-008
owner: lead
brief: F-008
depends_on: [T-097, T-098, T-099, T-100, T-101]
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 1          # reviewer increments; max 2
user_ok: true             # user, 2026-10-15: "user_check is oke, you can merge the epic into main when its done"
pr: 114
---
## Goal
The Session communication popup is a small isometric kingdom: the user is the king in the castle, the team and
its projects are the town around it, and the user can tell from the scene alone who works, who is idle, who
talks, and whether anyone needs them.

## Acceptance
- [ ] The view is an isometric (2.5D) scene with a castle, buildings with roofs, paths, a central square and a
      boundary wall with towers
- [ ] The castle is always present and clearly distinct from the session buildings
- [ ] When at least one session needs the user's attention, the castle shows a visible marker; with none, not
- [ ] team-hq sessions stand in the main court around the square; each other project's sessions stand together
      in their own district
- [ ] Each session appears as exactly one building, labelled with its name, with F-007's roster rule
- [ ] Building state is distinguishable without reading text: active, idle ("idle N min"), closed ("stopped")
- [ ] Each working subagent appears as a worker at its parent's building; none for finished ones
- [ ] A new session-to-session message produces one mailman walking the paths sender -> receiver; no all-time
      connections
- [ ] A message involving the user is shown as a mailman to or from the castle
- [ ] Buildings keep stable positions; a new district or building appears without moving existing ones
- [ ] The message feed (last 40) is unchanged
- [ ] On desktop the popup may use the full screen, and the scene fills it
- [ ] On phone the scene is a vertical scroll: castle, then main court, then each district; labels readable
- [ ] Nothing about the scene is computed while the popup is closed
- [ ] Full CI green on the epic PR

## Notes (lead)
- Brief open questions, lead's technical answers: building kinds `hall` (lead), `workshop` (engineers), `guild`
  (reviewer, designer), `house` (project sessions); desktop scales the whole scene to fit, phone scrolls
  vertically; "needs the user" = any F-001 alert item or a `pending` permission request. The data has no
  message *from* the user (detection unchanged per brief), so castle mailmen run from a session when it starts
  to need the user (new `session:` alert or pending permission).
- User, 2026-10-15: the user check is OK; merge into `main` when done and update the user's `main` afterwards.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
round 1: approve
