# Sprint summary: sprint 13 (2026-10-18, phase 3)

F-009 (Dual-view player, greybox) is built and on `main` (epic PR #13, `bca83ac`). Ten PRs merged into `epic/F-009`, every
one approved in round 1. The user OK'd G-001 (new `EnhancedInput` dependency) and G-008 (map play-test). F-010 is ticketed;
`epic/F-010` is not opened yet, at the user's request. Decision 0013 sets the game code split: C++ core, Blueprints for content.

## Shipped

### my-game-project

| Ticket | Title | PR | Rounds |
| --- | --- | --- | --- |
| G-001 | `AIndyCharacter` + game mode: walk, run, jump, coyote and buffer timers | #4 | 1 |
| G-010 | Blueprint-facing API: tunables, speed modifiers, jump/land events | #5 | 1 |
| G-002 | Crouch (hold or toggle, ceiling check) | #6 | 1 |
| G-003 | Roll | #7 | 1 |
| G-004 | Third-person camera, orbit, pull-in | #8 | 1 |
| G-005 | First-person view, 0.3 s toggle glide | #9 | 1 |
| G-006 | Aim test input, facing, sidestep | #10 | 1 |
| G-007 | View settings (FOV per view, sensitivity) | #11 | 1 |
| G-008 | Greybox test map `L_Greybox` | #12 | 1 |
| G-009 | Epic F-009 to `main` | #13 | 1 |

### claude-dashboard

Nothing this sprint.

## Open

| Item | Status | Next step |
| --- | --- | --- |
| F-010 traversal, G-011..G-020 + epic G-021 | backlog | `epic.sh open F-010 my-game-project` when the user says so, then dispatch G-011 |
| F-015 animations, F-011, F-014, F-013, F-012 | approved briefs | ticket one epic at a time after the previous is on `main` (order in `ROADMAP.md`) |
| T-103 (claude-dashboard) | ready | not dispatched this sprint |
| T-045 | backlog, owner user | approve/deny check from a paired device |

## Waiting on the user

- Pull `main` in `N:\Projects\MyGameProject` (local checkout has an uncommitted `.claude/settings.json`, so it was not fast-forwarded).
- Delete the leftover folders `N:\worktrees\my-game-project-G-006` and `-G-008` (`rm -rf` is denied to the lead).
- Play-test feel in `L_Greybox`: crouch/roll have no animation until F-015; Left Alt as roll may clash with Windows.
- Dashboard browser checks: F-008 kingdom, F-007 feed/roster, whole Vue client (sprint 10), Vite switch. T-045 check. `N:\tmp-t044\`.
- Design session: phone/tablet app + voice (decision 0007 "Later").

## Decisions

- [0013 game code split: C++ core, Blueprints for content](../decisions/0013-game-code-split-cpp-blueprint.md)
- Lead calls: G-011 (placeholder crouch/roll visuals) dropped for F-015; events named `OnIndyJumped`/`OnIndyLanded` because `ACharacter::OnJumped` exists (open question whether `OnIndyLanded` duplicates `LandedDelegate`).

## Metrics

Engineer cost $0.32-0.84 per ticket (about $5.5 for 10 tickets with the G-008 rerun), reviews $0.09-0.20. Rows are in
`metrics/baseline.md`. Infrastructure trouble, not rework: an editor start failed once (G-001), editors outlived runs
(G-006, and the user's own on G-008), the engineer was denied `Stop-Process` (G-008), and the first merge call for
epic #13 exited without merging.

## Next sprint

1. `epic.sh open F-010`, dispatch G-011 (traversal volumes), then G-012..G-018 in order.
2. G-019 fall damage, G-020 traversal map (needs `user_ok` to merge), epic G-021.
3. Ticket F-015 (animations) after F-010 is on `main`, then F-011, F-014, F-013, F-012.
4. Look into why game editors outlive runs, and how `merge.sh` can exit 0 with the PR open.
