# 0005: Answer permission prompts from the dashboard through a session-scoped hook

Date: 2026-10-09. Status: **proposed** (needs the user's OK before T-034..T-036 go to `ready/`).
Decided by: the user (log-only safety, skip the allow/deny test: option 3), the lead (structure), for brief F-005.

## Context

F-005 wants a "waiting for you" session's permission prompt answered from the dashboard. The CLI (2.1.295) has no
command for it. Spike T-030 showed that a `PermissionRequest` hook fires for a `--bg` session's prompt and receives
`session_id`, `tool_name` and the full `tool_input` (e.g. the exact Bash command), and that the session shows
`waiting` / `permission prompt` while the hook holds. Whether allow/deny returned by the hook lets the session go on
was not tested (the classifier refused it to the engineer); the user chose to rely on Claude Code's documented hook
behaviour and prove it in the first build ticket.

## Decision

- **Scope: only sessions the dashboard starts or continues.** `claude-cli.ts` adds `--settings <file>` to its
  `--bg` start and `--bg --resume` calls; that file holds just the `PermissionRequest` hook. Nothing is written to
  `~/.claude/settings.json`; sessions started in a terminal keep prompting there.
- **Hook = a small Node script in the repo** (no dependency). It sends the request to the dashboard on `127.0.0.1`
  with a hook secret (a random file in `DATA_DIR`, never sent to browsers), then waits for the answer and prints the
  documented `PermissionRequest` decision (`allow` or `deny`, with a short message on deny).
- **Fail safe to today's behaviour:** dashboard not running, secret wrong, or no answer before the hook timeout ->
  the hook returns no decision and the session shows its normal prompt (answerable with `claude attach`). The
  dashboard then marks the request "expired".
- **Who may answer:** same as the existing controls (signed-in device, commands enabled), as the brief asks. Any
  signed-in device, phones on the LAN included.
- **Never offered:** "always allow" (the hook ignores `permission_suggestions`), bypass mode, bulk approve.
- **Log:** every answer is audited (time, device, session, tool, request text up to 500 chars, allow/deny/expired)
  and shown as an approval log in the dashboard.

## Consequences

- Tickets: T-034 (hook + `--settings` wiring + pending store; proves allow/deny on a real session, `auth`), T-035
  (decide endpoint + audit, `auth`), T-036 (UI: request on the waiting session, approve/deny, approval log). All need
  `user_ok`.
- If T-034 shows the hook's allow/deny does not take effect, F-005's approve/deny stops there and comes back to the
  user; T-031 (continue ended terminal sessions) already shipped on its own.
- The request text is untrusted (it comes from the session); it is shown as text (`esc()`), never as HTML.
- Revisit "any signed-in device may approve" if the dashboard is ever reachable from outside the LAN (brief).
