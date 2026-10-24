---
id: F-018
title: Projects on the box - repo sync, auto-deploy on main, Docker and dev clones
status: approved
builder: user + Claude on the box (not the team)
priority: must
repos: [homelab]
---
## Problem
The user's projects (the claude-dashboard, small scripts and services) only run on the Windows PC. The homelab
box (F-016) is always on, but nothing on it keeps their repos up to date or runs them, and every update would mean
logging in and pulling by hand.

## Outcome
The box keeps a listed set of repos in sync by itself: a push to `main` shows up on the box within about a minute,
and a project that runs as a service is rebuilt and restarted without the user touching it. The claude-dashboard is
the first such service, reachable from any tailnet device. Next to these deploy clones, the user (over Remote-SSH)
and Claude on the box work in their own dev clones that sync never touches. Containers run without giving Claude
root. Depends on F-016.

## User stories
- As the user, I can add a repo to one list in the homelab repo, so that the box starts keeping it in sync.
- As the user, I can push to `main` and see the change running on the box within minutes, so that I never deploy by hand.
- As the user, I can open the dashboard from my phone or laptop over Tailscale, so that it no longer depends on my PC being on.
- As the user, I can work on a repo on the box from Windows through VS Code Remote-SSH, and Claude on the box can build and test the same repo, so that my main PC stays free.
- As the user, I can see per repo what is deployed and whether the last deploy worked, so that a failed deploy never goes unnoticed.

## Acceptance criteria
- [ ] The repos to sync are one list in the homelab repo. After a repo is added to the list and the change is pushed, the box has a deploy clone of it within 2 minutes.
- [ ] Within 60 s of a push to `main` of a listed repo, that repo's deploy clone on the box is at the new commit, with no manual step. Only `main` is synced.
- [ ] Nothing on the box is reachable from the internet to make this work; the box only makes outbound connections.
- [ ] Sync reaches private repos with read-only GitHub access; the sync credentials cannot push.
- [ ] A listed repo with a compose file is rebuilt and running at the new commit within 5 minutes of the push. If the build or start fails, the previous version keeps running and the failure shows in the status command.
- [ ] Deploy clones always match `origin/main`; nobody edits them. Dev clones live in a separate place, are never pulled, reset or deleted by sync, and uncommitted work in them survives any number of syncs.
- [ ] Containers run under rootless Docker. Claude on the box can build, run and stop containers, while its account still has no `sudo` and is not in the `docker` group.
- [ ] After `sudo reboot` and after a power cut, all deployed services come back on their own, and sync resumes, without a keypress.
- [ ] Deployed services are reachable from the user's tailnet devices only; from the home LAN outside Tailscale they are refused.
- [ ] The claude-dashboard runs as a deployed service and opens at the homelab's tailnet name from the user's phone and laptop. Which sessions it shows is whatever it sees on the box.
- [ ] From Windows, VS Code Remote-SSH opens a dev clone on the box and runs the project there; Claude Code on the box can clone, build and test the same repo in a dev clone (Node available for both).
- [ ] One command on the box shows per listed repo: deployed commit, time of last sync, and result of the last deploy.
- [ ] The docs in the homelab repo cover: adding and removing a repo, how sync and deploy work, deploy vs dev clones, rolling back (e.g. pushing a revert), and rebuilding all of it on a fresh box.

## Out of scope
- Claude changing network or machine settings (firewall, netplan, services, users, storage): F-019.
- Branches other than `main`, and preview deploys of branches.
- Making the dashboard show sessions from the Windows PC: a separate claude-dashboard brief.
- Building MyGameProject on the box; running team-hq scripts or engineers on the box.
- Prebuilt images, an image registry or CI building for the box; the box builds from source.
- Anything reachable from the internet.

## Open questions
- Near-instant needs a push channel without inbound access: a self-hosted GitHub Actions runner (runs workflow code from the listed repos) or an outbound webhook relay. Builder's call at build time, within the "outbound only" criterion.
- Does Claude on the box get push access from dev clones (a write credential on the box), or does it only commit and the user pushes?
- When a repo is removed from the list: stop its service only, or also delete its deploy clone?
- Who builds it?
  Answer (user, 2026-10-24): the user and Claude on the box. **Not for the team: the lead does not plan tickets for this brief.**

## Questions from lead
