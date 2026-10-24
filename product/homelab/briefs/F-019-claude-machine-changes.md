---
id: F-019
title: Claude makes machine changes - instant allowlist, approve-by-PR, auto-revert
status: approved
builder: user + Claude on the box (not the team)
priority: must
repos: [homelab]
---
## Problem
Since F-016, Claude on the box has no root: every machine change (open a port, restart a service, install a
package) is a script Claude writes and the user runs over SSH. Small admin changes stall until the user logs in,
and the user is the bottleneck for every one of them, even trivial ones.

## Outcome
Claude makes routine machine changes itself, and gets risky ones applied with one tap from the user. Low-risk actions
run at once from a narrow allowlist. Everything else becomes a PR on the homelab repo: the user gets a push on their
phone, merges, and the box applies it. A firewall or network change that cuts off access rolls itself back. Claude
still never gets a root shell. Success: routine admin changes go live without the user SSHing in to run a script,
and no change ever leaves the box unreachable. Depends on F-016 and F-018.

## User stories
- As the user, I can let Claude restart services, install Ubuntu packages, open tailnet ports and apply security updates itself, so that small changes don't wait for me.
- As the user, I get a push on my phone when Claude has a risky change ready, and I approve it by merging the PR, so that I can approve from anywhere.
- As the user, I can trust that a firewall or network change that locks me out undoes itself, so that I never need a monitor or a rebuild to recover.
- As the user, I can see every change Claude made, instant or approved, so that nothing on the box changes unnoticed.

## Acceptance criteria
- [ ] **Instant path.** Claude on the box can, without asking: start, stop and restart existing system services; install packages by name from Ubuntu's own repos; open and close ports on the Tailscale interface; apply pending Ubuntu security updates.
- [ ] Claude still can't get a root shell or run anything else as root: an interactive root shell, editing a root-owned file, installing a local `.deb`, passing extra options to the package manager, and running any command outside the list all fail.
- [ ] The instant path can't lock the user out: stopping or restarting SSH or Tailscale, and changing any SSH, LAN or non-Tailscale firewall rule, are refused on it.
- [ ] Security updates on the instant path skip the NVIDIA driver and the kernel.
- [ ] **Approval path.** Every other machine change in scope (firewall rules beyond tailnet ports, new or edited system services, network config such as netplan, DNS and Tailscale settings, package removal) can only reach the box as a PR on the homelab repo.
- [ ] Within 1 minute of Claude opening such a PR, the user's phone gets a push notification with a one-line summary and a link to the PR.
- [ ] Within 5 minutes of the user merging it, the box has applied the change, with no SSH login and no inbound connection from the internet.
- [ ] Claude on the box can't merge or push to the homelab repo's `main`; only the user can approve.
- [ ] **Safety net.** After a firewall or network change is applied, the box checks it can still be reached over Tailscale. If it can't, or the user doesn't confirm (from the phone or over SSH) within 5 minutes, the change is rolled back by itself and the user gets a push saying so.
- [ ] Test: an approved change that blocks SSH over Tailscale is rolled back on its own, and SSH works again within 10 minutes of the merge.
- [ ] After every applied change, instant or approved, the F-016 health check runs. If it fails, the user gets a push.
- [ ] **Record.** Every instant action is logged with time, command and Claude's reason. One command on the box lists instant and approved changes, newest first.
- [ ] Once a day the user gets one push that summarises what changed (or that nothing changed).
- [ ] The status command flags any instant change that isn't yet recorded in the homelab repo, so a rebuild from the repo reproduces the box.
- [ ] The homelab docs cover: what is on the allowlist and why, how to approve, how auto-revert works, and how to add or remove an allowlisted action.

## Out of scope
- NVIDIA driver and kernel updates: they stay a manual, checklisted step for the user.
- Adding third-party package sources.
- Users, groups, disks, mounts and swap.
- Rebooting or shutting down the box.
- Anything reachable from the internet; approval and notifications must not need inbound access.
- Showing approvals in the claude-dashboard (would be a separate dashboard brief).

## Open questions
- Vision: the allowlist bends "no agent gets root".
  Answer (user, 2026-10-24): OK; `VISION.md` now says "no agent gets a root shell" (narrow allowlist, the rest needs approval).
- Do instant service and package changes also roll back on a failed health check, or only notify? Builder's call; this brief only requires auto-revert for firewall and network changes.
- The push channel (e.g. ntfy) must not let anyone else read the notifications or approve changes. Builder's call at build time.
- Who builds it?
  Answer (user, 2026-10-24): the user and Claude on the box. **Not for the team: the lead does not plan tickets for this brief.**

## Questions from lead
