---
id: F-005
title: Terminal-free session control
status: approved         # draft | approved | needs-design | parked | handed-off
priority: should         # must | should | could (the user decides)
repos: [claude-dashboard]
---
## Problem
The owner works with the dashboard open beside their work, but still has to open a terminal for
two things: answering a permission prompt when a session is "waiting for you", and taking over a
session that was started in a terminal or editor. Today the dashboard already starts, stops,
messages and reads logs of background sessions, and it flags "waiting for you", but it cannot
answer the prompt, and it refuses sessions open in a terminal.

## Outcome
The owner can do everything with their sessions from the dashboard and stops opening terminals.
Worked if, over a normal working week, no session needs a terminal to approve a prompt or to
continue it.

## User stories
- As the owner, I can see what a waiting session is asking permission for (the tool and the exact
  command or file) so that I can decide without opening a terminal.
- As the owner, I can approve or deny that request from the dashboard so that the session
  carries on.
- As the owner, I can resume a session that was started in a terminal or editor from the
  dashboard so that I can keep working on it without switching tools.
- As the owner, I can look back at which approvals I gave, and when, so that I know what ran.

## Acceptance criteria
- [ ] A session that is waiting on a permission prompt shows the tool name and the full command or
      target of the request in the dashboard.
- [ ] Approving the request in the dashboard makes the session continue and run that action; the
      session no longer shows as waiting.
- [ ] Denying the request makes the session continue without running the action; the session no
      longer shows as waiting.
- [ ] Every approval and denial is recorded with time, session, and the request text, and can be
      viewed in the dashboard.
- [ ] A session started in a terminal or editor can be continued from the dashboard, or the
      dashboard says clearly why it cannot (for example, still open in a live terminal).
- [ ] The "bypass permissions" mode stays unavailable; nothing in this feature offers it.
- [ ] All new actions need the same access token as the existing controls; without it they are
      refused.

## Out of scope
- Voice input or output.
- Running arbitrary shell commands outside of Claude sessions.
- Multiple users or per-user permissions (single owner).
- Bulk approve, "always allow" rules, and extra confirmation steps (the owner chose log-only
  safety: the access token plus the approval log).
- Worktree/branch creation, model/effort pickers, and task queues or scheduling.
- Access from outside the LAN.

## Open questions
- Does the Claude CLI let a background session's permission prompt be answered from outside? If
  not, what is the nearest acceptable behaviour? (Not yet verified; the lead should check first.)
- Can a session that is open in a live terminal be taken over safely, or only once it has ended?
- Approvals run commands, and security is a stated principle. The owner chose log-only; revisit
  if the dashboard is ever reachable outside the LAN.

## Questions from lead
- 2026-10-09 (lead) Q1 (answer a prompt from outside): `claude --help` (2.1.295) has no command for it; `claude attach` is an interactive terminal and `--permission-prompts` is `--print` only. Spike T-030 tests a `PermissionRequest` hook that hands the prompt to the dashboard. The approve/deny and approval-log tickets follow from its result (decision 0005, with the user). Brief stays `approved` until they exist.
- 2026-10-09 (lead) Q2 (live terminal sessions): no take-over. `--bg --resume` on a running session starts a copy (a fork), so the dashboard refuses and says why; an ended terminal session continues normally (T-031). Technical choice; tell me if the owner wants "continue as a copy" instead.
