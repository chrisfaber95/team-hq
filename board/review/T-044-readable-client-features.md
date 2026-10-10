---
id: T-044
repo: claude-dashboard
owner: eng-claude-dashboard-T-044
brief:                    # none: decision 0006
depends_on: [T-043]
contracts: []
labels: [auth]            # renames login, pairing and devices client code
budget_usd: 3
review_rounds: 0
user_ok: false
pr: https://github.com/chrisfaber95/claude-dashboard/pull/55
---
## Goal
The remaining client features and skins read like senior code, and the structure test runs with an empty allowlist.

## Acceptance
- [ ] Names, ternaries, constants and doc comments per decision 0006 in chat, devices, audit, alerts, popups,
      core/mood, team, launch, settings, login, pairing and `skins/`
- [ ] Behaviour unchanged: same markup, classes and endpoints; existing tests pass with only import and name updates
- [ ] No `src/client` entries are left in the `tests/code-structure.test.ts` allowlists or in `LEGACY_FILES` (server and tests entries stay: T-042, T-047, T-048); `npm run lint` passes
- [ ] `npm run typecheck` and `npm test` pass

## Notes (lead)
- From T-043 review: the new `*.logic.ts` files from T-043 (projects, sessions, usage, limits, messages, tooltip) have no own unit tests; add them here alongside this ticket's features.
- Last cleanup ticket; F-005's UI (T-036) builds on this layout afterwards.

## Hand-off (engineer writes, max 300 tokens)
PR #55: https://github.com/chrisfaber95/claude-dashboard/pull/55
- All client files (chat, devices, audit, alerts, popups, core/mood, team, launch, settings, login, pair, skins) pass the lint rules; every `src/client` entry is gone from `LEGACY_FILES` (the client structure allowlist was already empty). Server and tests entries stay.
- Behaviour unchanged, no exports renamed. `initDevices` split; QR drawing moved to new `devices/devices-qr.view.ts` (keeps devices.view.ts under 300 lines). New `pickCoreMood` helper.
- New unit tests for sessions, usage, limits, messages logic. projects and tooltip have no `*.logic.ts`, so nothing to test there.
- One test edit: `chat.view.test.ts` asserts source text, `p.sessionId` -> `pending.sessionId`.
- Local: typecheck, lint, test (407 pass), build ok. security-auditor: no findings. CI not checked, no browser check.
- Review focus: login.view.ts, pair.view.ts, devices.view.ts, devices-qr.view.ts (label auth; the repo has no `auth` GitHub label).
- Leftover outside the repo: `N:\tmp-t044\` (two scratch .py files); deletion was blocked, please remove.

## Review (reviewer writes, one line per round)

## Blocked
Acceptance 3 needs `LEGACY_FILES` empty and the structure allowlist empty, but those cover far more than this ticket's client list: with `LEGACY_FILES` emptied, `eslint src tests` reports 1038 errors in 71 files (client 161, server 362, tests 515), and `server/server.ts` and `server/transcripts/transcripts.ts` are still over 300 lines (OVERSIZED_ALLOWLIST). The ticket names only client areas, and the $3 budget cannot cover this. Question: split into client, server and tests tickets (and server.ts/transcripts.ts splits), or raise the scope and budget? Nothing was changed in the worktree.

## Lead (2026-10-10)
Split, not raised: acceptance 3 is now client-only. Server entries go with T-041/T-042, `tests/` with T-047/T-048; T-048 empties both lists. Re-run with `--rework`.
