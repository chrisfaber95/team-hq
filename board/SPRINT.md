# Sprint summary: sprint 3 (2026-10-09, phase 1)

F-002 Per-device LAN access, split into eight tickets and shipped in full, one engineer at a time. Run interactively:
lead (opus), `eng-claude-dashboard` (sonnet) in the main checkout, `reviewer`. (Sprint 2, F-001 alerts T-005..T-007,
was closed earlier the same day without a `/clear`; its numbers are in `metrics/baseline.md`.)

## Shipped

| Ticket | Title | PR | Review rounds |
| --- | --- | --- | --- |
| T-008 | Per-device tokens, loopback exemption, sliding sessions | #22 (a9c9296) | 2 (L3: failed save undid a revoke) |
| T-009 | Device create/list/revoke endpoints (PC only) | #23 (69709e2) | 1 |
| T-010 | Devices section on the PC | #24 (01eed20) | 1 |
| T-014 | Failed sign-in alert (F-001 mechanism) | #25 (023c934) | 1 |
| T-011 | QR pairing, `qrcode-generator` 2.0.4 | #26 (6a24066) | 2 (dependency policy file) |
| T-012 | Audit log names the device; `/api/audit` | #27 (440ce2f) | 1 |
| T-013 | Activity view with device filter | #28 (9429891) | 1 |
| T-015 | Session hardening (auditor L4/L5 from T-008) | #29 (3f78b71) | 1 |

Every F-002 acceptance criterion is shipped; the designer moves F-002 to Shipped in `ROADMAP.md`.

## Open

None. `backlog/`, `ready/`, `in-progress/`, `review/` and `blocked/` are empty.

## Waiting on the user

Nothing unticked in `NEEDS-YOU.md`. Checks only the user can do:
- End to end on a phone: add a device on the PC, sign in by token and by QR (self-signed cert warning expected),
  run/stop a session, revoke from the PC and confirm the phone is locked out; check the Activity view names the phone.
- Browser look at the new UI (Devices, QR, Activity, alerts, Team section) in all three skins; none was checked visually.
- Still unchecked from F-001: does a session's `status` become `waiting` on a permission prompt?

## Decisions

- [0003](../decisions/0003-device-tokens.md): hashed per-device tokens; loopback (socket and `Host`) needs no token
  (user's choice); no expiry, sliding sessions; failed sign-ins alert; `qrcode-generator` (user's choice).
  **Revisit before any outside access**: a same-PC proxy or tunnel would be loopback and bypass login.
- `scripts/merge.sh` (94880bf): for auth/deps/contract/migration tickets the prompt now tells the merge agent the user
  set `user_ok`; before that it rightly refused PR #22.

## Metrics

Engineer cost unknown (interactive runs, no `dispatch.sh` JSON). Merge runs $0.13-0.15 each, 6-9 turns.

| Ticket | PR size | Rounds | Messages (target 3) |
| --- | --- | --- | --- |
| T-008 | +614/-97 | 2 | 6 |
| T-009 | +286/-19 | 1 | 3 |
| T-010 | +338/-8 | 1 | 3 |
| T-014 | +187/-8 | 1 | 3 |
| T-011 | +605/-28 | 2 | 6 |
| T-012 | +341/-13 | 1 | 3 |
| T-013 | +339/-16 | 1 | 3 |
| T-015 | +272/-26 | 1 | 3 |

## Notes for next sprint

- Point the reviewer at specific auditor findings in the review request (done for T-008 L3; it caught the real issue).
- Engineers keep accepted auditor findings in the hand-off; collected below as candidates instead of widening tickets.
- The repo has no `auth`/`deps` GitHub labels; only the ticket labels drive `merge.sh`.

## Next sprint

Backlog is empty. Start from `product/briefs/` (any `status: approved`) and the user's next goals. Candidates:
1. Hardening from audits: IPv6 /64 bucketing for rate limit and sign-in alerts (T-014 M1/M2); short cache on
   `/api/audit` (T-012 L1); evict least-recently-used session and alert on cap eviction (T-015 M1).
2. Only if the user wants it: restrict prompt text in `/api/audit` to the PC (T-013 M1).
3. Verify `waiting` on permission prompts against a real session (small, docs-only if it holds).
4. `merge.sh`: leave the repo checkout on an updated `main` after merging (it ends on a detached HEAD today).
