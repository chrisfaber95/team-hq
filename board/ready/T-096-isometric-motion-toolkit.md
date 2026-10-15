---
id: T-096
kind: ticket              # ticket | epic (one per brief, the PR epic -> main; decision 0008)
repo: claude-dashboard
base: main                # epic/F-NNN for a brief's tickets; main for epic tickets and tickets without a brief
branch:                   # epic tickets only: epic/F-NNN
owner: eng-claude-dashboard
brief:                    # F-NNN when the ticket comes from a product brief
depends_on: []
contracts: []
labels: [low-risk]
budget_usd: 2
review_rounds: 0          # reviewer increments; max 2
user_ok: false            # user sets true to allow merging a ticket labelled auth/deps/contract/migration
pr:                       # engineer fills in, e.g. 88
---
## Goal
Engineers have a shared isometric (2.5D, old-school SimCity) SVG toolkit and a UI motion guide in the repo
before any scene or motion work. No visible change in the app: nothing uses the toolkit yet.

## Acceptance
- [ ] The six draft files from `N:/team-hq/drafts/isometric-motion/` are at their repo paths (table in its
      `README.md`): `docs/isometric.md`, `docs/motion.md`, `docs/isometric-example.svg`,
      `src/client/shared/iso.ts`, `src/client/shared/_iso.scss`, `tests/client/shared/iso.test.ts`; unchanged
      except fixes the checks demand (list them in the hand-off)
- [ ] `src/client/style.scss` loads `shared/iso` next to the other `meta.load-css` lines and defines the six
      motion tokens from `docs/motion.md` ("Timing") on `:root`
- [ ] The repo `CLAUDE.md` reference list names the two guides, with the line given in the draft README
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; the draft's `iso` tests run in the suite
- [ ] New and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- Source: draft by session `epic-branch-per-feature` at the user's request; its README has the copy plan.
  Copy, don't redesign. The lead deletes the draft folder after merge.
- If the classifier refuses the `CLAUDE.md` edit (as with `.claude/` in T-059), leave it out, finish the rest
  and say so in the hand-off; the lead routes it to the user.
- Don't run CPU measurements (off, user 2026-10-15), even where `docs/motion.md` mentions them.

## Hand-off (engineer writes, max 300 tokens)

## Review (reviewer writes, one line per round)
