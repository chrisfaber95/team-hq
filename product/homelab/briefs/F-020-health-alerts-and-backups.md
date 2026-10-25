---
id: F-020
title: Homelab health alerts, one overview, and backups of what the repo can't rebuild
status: needs-design         # draft | approved | needs-design | parked | handed-off
builder: user + Claude on the box (not the team)
priority: should
repos: [homelab]
---
## Problem
Once the box runs unattended, the user only learns about a problem when they happen to log in: a kernel update
that broke the driver, a full disk, a crashed service, or a box that's off entirely. The F-016 health check exists
but only runs when someone types it, and the state is spread over separate commands (health, deploys, LLM usage,
changes). Some state isn't in the repo at all (the Tailscale identity, SSH host keys, logins, the usage and change
logs), so if the old SSD dies, a rebuild from the repo still leaves the user re-pairing and re-logging in everything
and losing the history. The user worries about all four equally: hardware failure, an outage nobody notices,
lost data, and not knowing the box's state.

## Outcome
The box watches itself and pushes to the user's phone when something breaks and again when it recovers, and the
user also hears about it when the box is completely off. One overview, as a command and as a tailnet page, shows
everything at a glance. Every day, the state a rebuild can't recreate is copied to a USB disk on the box, and
restoring it after a rebuild brings the box back as the same machine. Success: a deliberate failure (a stopped
service, the box switched off) reaches the phone without the user looking, and a rebuild drill from a wiped SSD
plus the USB backup ends with no re-pairing, no host-key warning and the logs intact. Depends on F-016; uses
F-017, F-018 and F-019 (the push channel).

## User stories
- As the user, I get a push on my phone when something on the box goes wrong, and one when it's fixed, so that I never find out days later.
- As the user, I hear about it when the box is off or offline, so that "no news" really means the box is fine.
- As the user, I can see the whole state of the box in one command over SSH or one page on my phone, so that I don't have to run four commands.
- As the user, I can rebuild the box from a blank SSD and restore the USB backup, so that it comes back as the same machine with its history.

## Acceptance criteria
- [ ] **Watching.** The health check runs by itself at least every 5 minutes. It covers the F-016 items (driver/GPU, network, disk use, pending reboot) plus: each deployed service (F-018) running, the LLM helper (F-017) answering, and the last backup succeeded within the past 26 hours with the USB disk present and not nearly full.
- [ ] Within 10 minutes of any check starting to fail, the user's phone gets a push that names the failing check. Within 10 minutes of it passing again, a recovery push follows.
- [ ] A check that keeps failing sends no repeat pushes; it is listed in the F-019 daily summary until it recovers.
- [ ] When the box is off, or can't reach the internet, the user gets a push within 15 minutes, without anything inbound to the home network.
- [ ] Test: stopping a deployed service, filling the disk past the warning level, and pulling the box's power each produce the push above (and a recovery push for the first two).
- [ ] **Overview.** One command on the box shows: each health check with pass/fail and since when, deploy status per repo (F-018), LLM usage totals for the last 7 days (F-017), the 5 latest machine changes (F-019), and the last backup's time, result and USB free space.
- [ ] The same overview is a read-only web page at the homelab's tailnet name, readable on the phone, at most 5 minutes old. It shows no secrets and has no buttons that change anything.
- [ ] The overview page is reachable from the user's tailnet devices only; from the home LAN outside Tailscale it is refused.
- [ ] **Backups.** Once a day, the box copies to a USB disk plugged into it: the Tailscale identity, the SSH host keys, the Claude Code and `gh` logins, the push-channel credentials, any other secret or setting a rebuild from the repo can't recreate, and the F-017 usage log and F-019 change log.
- [ ] The backups keep the last 14 days; older ones are removed on their own.
- [ ] Backup files on the USB disk are readable only by root; Claude's account on the box can't read them.
- [ ] A failed backup, or a missing or nearly full USB disk, fails the health check (and so pushes).
- [ ] **Restore.** One documented restore step, run after following the F-016 checklist on a wiped SSD, brings back the backed-up state: the box rejoins the tailnet under the same name without a new login, SSH from Windows gives no host-key warning, Claude Code and `gh` work without logging in again, and the usage and change logs still hold their history (`user_check: true`: the user does this drill once).
- [ ] The homelab docs cover: what is checked and how often, what pushes look like and how to silence one, what is and isn't backed up, and how to restore.

## Out of scope
- Backing up service data (Docker volumes, databases) and dev-clone work: services rebuild from their repos, and work that matters gets pushed.
- Encrypting the backups: the USB disk stays plugged into the box, so it is as safe as the box (the user's choice).
- Off-site or cloud backups, and copies to the Windows PC.
- Hardware wear warnings (SSD SMART, GPU temperature) and trends or graphs over time.
- Showing any of this in the claude-dashboard (would be a separate dashboard brief).
- Actions from the overview page (restart, approve, silence): it is read-only.
- Anything reachable from the internet.

## Open questions
- "Box is off" can't be detected by the box itself: an outside heartbeat service (outbound pings, it pushes when they stop) or another always-on device. Builder's call at build time, within "nothing inbound".
- Which USB disk and how big: the user picks one; the backup set is small (secrets and logs), so any spare disk will do.
- The 5-minute check interval, the 14-day retention and the "nearly full" levels are defaults; change them at review if they feel wrong.
- Mounting the USB disk needs root (F-019 keeps disks and mounts out of Claude's reach): a one-off script the user runs.

## Questions from lead
- 2026-10-25, storage change (see F-016): the user picks the 2 TB external USB HDD as the backup disk, which answers
  "Which USB disk and how big". If the HDD also holds other data, that data has no backup, because the backups
  land on the same disk. Should the brief say that nothing may live only on the HDD, or add "data kept only on the
  HDD" to Out of scope?
