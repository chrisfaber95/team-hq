---
id: T-103
kind: ticket              # ticket | epic (one per brief, the PR epic -> main; decision 0008)
repo: claude-dashboard
base: main                # epic/F-NNN for a brief's tickets; main for epic tickets and tickets without a brief
branch:                   # epic tickets only: epic/F-NNN
owner: eng-claude-dashboard
brief:                    # none: team-hq decision 0011 (board per repo)
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 3
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:                       # engineer fills in, e.g. 88
---
## Goal
The Team board panel shows the tickets of every repo again, now that team-hq keeps one board per repo
(`board/<repo>/<column>/` instead of `board/<column>/`).

## Acceptance
- [ ] `readTeamBoard` reads every `board/<repo>/<column>/` folder under the team-hq dir: `counts` sum each column over all repos, and the In progress / Review / Blocked lists hold the tickets of all repos (ids like `T-103` and `G-001`), sorted by id, still capped at `LIST_MAX`
- [ ] `board/NEEDS-YOU.md` is still read from `board/`; a folder in `board/` without stage folders (or a file) is ignored; no team-hq dir or no `board/` still gives `null`
- [ ] Still strictly read-only on team-hq (only the read calls listed in the file's header comment)
- [ ] Server test in `tests/server/` covers two repo boards, an empty repo board, and NEEDS-YOU at the root
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Module: `src/server/features/team/team.ts` only. The `TeamBoard` type and the client panel stay as they are:
  the id prefix already shows the repo (`T` dashboard, `G` game).
- The old flat layout doesn't need to keep working; team-hq has moved (decision 0011 in team-hq).
- Real layout to test against: `N:\team-hq\board\` (`claude-dashboard/`, `my-game-project/`, each with
  `backlog ready in-progress review blocked done`, plus `NEEDS-YOU.md`, `SPRINT.md`, `TEMPLATE.md` at the root).

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
