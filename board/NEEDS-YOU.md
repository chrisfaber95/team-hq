# Needs you

The lead (and `scripts/dispatch.sh` / `review.sh`) append one line per item. Tick it when handled.

- [x] 2026-10-09 T-008..T-012, T-014: F-002 device tokens are `auth` work (T-011 also `deps`: qrcode-generator); each needs your `user_ok: true` to merge. Design in decisions/0003. (2026-10-09: user set user_ok on T-008..T-014)
- [x] 2026-10-09 T-015: new `auth` follow-up (T-008 audit L4/L5), written after you set user_ok on T-008..T-014; set `user_ok: true` if it is covered too. (user set user_ok 2026-10-09)
- [x] 2026-10-09 T-008: merge of PR #22 stopped (exit 0, PR state OPEN). Log: logs/T-008.log Merge agent wanted the user OK stated; merge.sh now passes it. Merged a9c9296.
- [x] 2026-10-09 T-019: F-003 model summary runs `claude -p --model haiku` through claude-cli.ts (`auth`); set `user_ok: true` when you are fine with it merging. Design in decisions/0004. (user set user_ok 2026-10-09)
- [x] 2026-10-09 T-020: reviewer run for PR #32 stopped (exit 1, success turns=3 cost=$0.08 error). Log: logs/T-020.log Cause: account session limit (resets 14:00), not the PR; re-run `review.sh T-020 32` after reset. (lead: session limit; re-run after reset)
- [x] 2026-10-09 T-018: engineer run stopped (exit 1, success turns=1 cost=$0.78 error). Log: logs/T-018.log (lead: session limit; re-run after reset)
- [x] 2026-10-09 T-023: LAN startup output names the localhost URL for this PC (your dev:lan report); `auth` label (LAN mode), output text only, no sign-in rule change. Set `user_ok: true` to let it merge after review. (user set user_ok 2026-10-09)
- [x] 2026-10-09 T-024: QR sign-in fix (your report: QR opens the login page): confirm page + POST instead of a GET that spends the code; `auth`. Set `user_ok: true` to let it merge after review. (user set user_ok 2026-10-09)
- [x] 2026-10-09 T-031: continue ended terminal/editor sessions from the dashboard (F-005), `auth` (session control). Set `user_ok: true` to let it merge after review. (user set user_ok 2026-10-09)
- [x] 2026-10-09 F-005: approving prompts from the dashboard lets any signed-in device (incl. phones on the LAN) allow tool runs, and likely needs a `PermissionRequest` hook in your Claude settings. Spike T-030 first; the design comes to you as decision 0005 before any of it is built. (lead: decision 0005 proposed; the hook is scoped to dashboard sessions via `--settings`, no change to your Claude settings)
- [x] 2026-10-09 T-030: spike blocked: the auto-mode classifier refused to let the engineer answer a held `--bg` permission prompt (allow/deny step). Choose: you run that step yourself (lead gives commands), allow it for that engineer run in `engineer.settings.json`, or skip the test and rely on documented hook behaviour. Lead will not run it in the engineer's place. (user chose option 3, 2026-10-09; T-030 closed, design in decisions/0005)
- [x] 2026-10-09 T-025: engineer run stopped (exit 1, success turns=2 cost=$0.47 error). Log: logs/T-025.log (lead: session limit; resumed with --rework after reset)
- [x] 2026-10-09 T-027: engineer run stopped (exit 1, success turns=1 cost=$0.56 error). Log: logs/T-027.log (lead: session limit; resumed with --rework after reset)
- [x] 2026-10-09 T-025: merge of PR #40 stopped (CI not green (1 of 2 checks not passing)). Log: logs/T-025.log (lead: CI was still pending, not failing; re-merged after green)
- [x] 2026-10-09 F-005: approve decision 0005 (`decisions/0005-answer-permission-prompts.md`): a hook only in dashboard-started sessions, any signed-in device may approve/deny, everything logged. Then T-034..T-036 (`auth`) go to ready; each still needs `user_ok` to merge. (user approved 0005, 2026-10-09)
- [ ] 2026-10-09 T-030: remove the leftover worktree `N:\worktrees\claude-dashboard-T-030` when convenient (spike scratch, nothing to keep).
- [ ] 2026-10-09 T-034: when it reaches review, run the proof steps in its hand-off on the PR branch (answer allow / deny once each), then set `user_ok: true` if both worked.
