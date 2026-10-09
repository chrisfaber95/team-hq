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
- [ ] 2026-10-09 T-031: continue ended terminal/editor sessions from the dashboard (F-005), `auth` (session control). Set `user_ok: true` to let it merge after review.
- [ ] 2026-10-09 F-005: approving prompts from the dashboard lets any signed-in device (incl. phones on the LAN) allow tool runs, and likely needs a `PermissionRequest` hook in your Claude settings. Spike T-030 first; the design comes to you as decision 0005 before any of it is built.
