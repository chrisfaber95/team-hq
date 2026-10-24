---
id: F-016
title: Headless homelab base - Ubuntu, GPU, private access, Claude Code
status: approved
builder: user + Claude on the box (not the team)
priority: must
repos: [homelab]
---
## Problem
The old desktop (i7-4790K, 16 GB DDR3, GTX 1080, 500 GB SSD) sits unused. The user wants it as an always-on
Ubuntu machine for a local LLM and their projects, but there is no setup yet, and the GTX 1080 only works with
an older NVIDIA driver (see `research/hardware-and-local-llm.md`).

## Outcome
A headless box the user reaches from their Windows PC over their private network. The GPU works,
Claude Code is ready on it, and the box can be rebuilt from scratch by following its repo. Success: from a
blank SSD, the user follows the checklist and ends with a box where the health check passes, and Claude on
the box can take over the next feature (F-017).

## User stories
- As the user, I can SSH into the box from my Windows PC, at home or away, so that I never need a monitor on it.
- As the user, I can trust that the box comes back on its own after a reboot or power cut, with GPU and network working.
- As the user, I can run Claude Code on the box, without it ever having root, so that it can do the rest of the setup safely.
- As the user, I can rebuild the box from a blank disk by following one checklist, so that nothing about it lives only in my head.

## Acceptance criteria
- [ ] From the Windows PC, `ssh` to the box by name works over Tailscale, both at home and from another network; login works only with a key (a password login is refused).
- [ ] From the home LAN, only SSH answers on the box; every other port is refused.
- [ ] `nvidia-smi` on the box shows the GTX 1080 with 8 GB and no process using VRAM while idle (no desktop session).
- [ ] The root file system has the whole SSD (about 450 GB usable), and there is swap.
- [ ] After `sudo reboot`, and after pulling the power and plugging it back in, the box comes back without a keypress and the health check passes.
- [ ] The health check is one command that reports driver/GPU, network, disk use and a pending reboot, and exits non-zero when any of them is wrong.
- [ ] Claude Code runs on the box, logged in, with `gh` authenticated; Claude can clone a private repo of the user's.
- [ ] Claude on the box cannot run `sudo`; every step that needs root exists as a script in the repo that the user runs.
- [ ] One checklist in the repo covers every step from BIOS settings to a working driver, including the manual ones; following it on a wiped SSD reproduces this state (`user_check: true`: the user does this rebuild once).

## Out of scope
- The local LLM (Ollama, models, the helper API): F-017.
- Projects, Docker and Node on the box: F-018.
- A desktop GUI, a RAM upgrade, and access from the internet outside Tailscale.
- Running team-hq engineers on the box.

## Open questions
- Name: `homelab` for both the repo and the hostname?
  Answer (user, 2026-10-24): yes, `homelab`.
- Who builds it: team engineers write the checklist and scripts in a `homelab` repo on Windows and the user applies them on the box, or the user and Claude on the box build it directly from this brief?
  Answer (user, 2026-10-24): the user and Claude on the box. **Not for the team: the lead does not plan tickets for this brief.**

## Questions from lead
