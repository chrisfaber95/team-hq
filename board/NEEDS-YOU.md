# Needs you

The lead (and `scripts/dispatch.sh` / `review.sh`) append one line per item. Tick it when handled.

- [x] 2026-10-09 T-008..T-012, T-014: F-002 device tokens are `auth` work (T-011 also `deps`: qrcode-generator); each needs your `user_ok: true` to merge. Design in decisions/0003. (2026-10-09: user set user_ok on T-008..T-014)
- [x] 2026-10-09 T-015: new `auth` follow-up (T-008 audit L4/L5), written after you set user_ok on T-008..T-014; set `user_ok: true` if it is covered too. (user set user_ok 2026-10-09)
- [x] 2026-10-09 T-008: merge of PR #22 stopped (exit 0, PR state OPEN). Log: logs/T-008.log Merge agent wanted the user OK stated; merge.sh now passes it. Merged a9c9296.
- [ ] 2026-10-09 T-019: F-003 model summary runs `claude -p --model haiku` through claude-cli.ts (`auth`); set `user_ok: true` when you are fine with it merging. Design in decisions/0004.
