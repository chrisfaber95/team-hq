# Sprint summary: sprint 11 (2026-10-15, phase 2)

F-007 (live session communication, "the city") is built and waits for the user's browser check. The team also
landed light CI for epic branches (decision 0008) and an isometric toolkit + motion guide for the next scene work.
8 tickets merged, every one approved in round 1; main CI green. The user approved everything this sprint up front.

## Shipped

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| T-089 | subagent hand-backs carry `agentId` | #101 | 1 |
| T-090 | city model: shops, workers, postmen (pure, tested) | #102 | 1 |
| T-091 | city view in the Session communication popup | #104 | 1 |
| T-092 | `measure-cpu.mjs --popup` + "Before F-007" numbers | #103 | 1 |
| T-093 | "After F-007" CPU numbers (open vs closed +0.08 desktop, +0.09 phone; limit 0.1) | #106 | 1 |
| T-094 | CI: tests only on pushes to / PRs into `main`; typecheck + lint always | #105 | 1 |
| T-095 | postmen always walk (no `prefers-reduced-motion`; guard test) | #108 | 1 |
| T-096 | isometric SVG toolkit (`shared/iso.ts`) + `docs/isometric.md`, `docs/motion.md` | #107 | 1 |

## Open

| Item | Status | Next step |
| --- | --- | --- |
| F-008 kingdom view | brief approved (designer, 2026-10-15), **no tickets yet** | write tickets; first epic (see Next sprint) |
| T-045 | backlog, owner user | user's approve/deny check from a paired device |

## Waiting on the user

- **F-007 browser check** (NEEDS-YOU 2026-10-15): city states, postmen, workers, stable shops, feed, phone.
- Browser check of the whole Vue client (sprint 10 line) and the older T-050/T-052 check.
- T-045 approve/deny check; remove `N:\tmp-t044\`.
- Design session: phone/tablet app + voice (decision 0007 "Later").
- F-008: consider setting `user_check: true` in the brief so the epic waits for your browser check before `main`.

## Decisions

- [0008](../decisions/0008-epic-branches.md): one epic branch per brief, light CI on ticket PRs. Written by the
  user's `epic-branch-per-feature` session; committed by the user (c68d030) after the classifier refused the lead.
- User, 2026-10-15: no CPU measurement runs in tickets from now on (lead memory; F-008 brief says the same).

## Metrics

Engineer $3.13, reviewer $1.02 for 8 PRs (rows in `metrics/baseline.md`). Engineer runs took 4-19 turns; no
rework, no session-limit stop. Messages: 1 per ticket, 2 for T-092/T-093 (measurement cut, then stopped).

## Notes for next sprint

- **The lead's ticket notes can break repo rules.** T-091's notes asked for `prefers-reduced-motion`, which
  `docs/architecture.md` "UI conventions" forbids; the reviewer approved it. Check repo conventions before adding
  a "nice to have" to Notes.
- **CI "pending" is not "failing".** merge.sh refused T-089 while CI ran; since then the lead waits with
  `gh pr checks <pr> --watch` before merge.sh. Merges ran one at a time; no conflicts this sprint.
- **The classifier refuses lead commits of `CLAUDE.md`, `.claude/`, scripts and settings** ("Self-Modification"),
  even with the user's chat approval. Leave those for the user, with the command to run.
- T-096 edited the dashboard's `CLAUDE.md` through an engineer without a refusal.
- `epic.sh open` pushes the epic branch directly, not through `git-workflow-manager` (told the epic session).
- `write-ticket` step 5 (NEEDS-YOU for contract/deps/auth) sits under the new epic section; the user's session
  should move it back.

## Next sprint

1. F-008 (first epic): `scripts/epic.sh open F-008 claude-dashboard`, then the epic ticket + children with
   `base: epic/F-008`. Draft split: kingdom model (court + districts, castle "needs you", castle mailmen) ->
   isometric layout (desktop wide, phone vertical) -> scene (castle, buildings, wall, square) -> motion (workers,
   mailmen on paths); popup full-screen on desktop in parallel. No CPU measurement.
2. Turn the user's F-007 browser-check findings into tickets first (they may change F-008).
3. T-045 when the user has run the device check.
