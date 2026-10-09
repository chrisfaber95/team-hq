---
id: F-002
title: Per-device LAN access
status: handed-off         # draft | approved | needs-design | parked | handed-off
priority: must           # must | should | could (the user decides)
repos: [claude-dashboard]
---
## Problem
The owner wants to use the dashboard from a phone or tablet on the LAN as comfortably as at the PC.
Today LAN mode has one shared login token for every device. Losing a device means changing the token
for all of them, and nothing shows which device did what. When away from the PC, the owner falls back
to switching terminals by hand.

## Outcome
Each LAN device has its own named, revocable token, and has full control like at the PC. Nobody
without a token gets anything. Every command can be traced to a device. Success: the owner signs in
on a phone, runs and stops sessions, revokes that phone from the PC, and the phone is locked out at once.

## User stories
- As the owner, I can create a named device token on the PC so that each phone or tablet has its own login.
- As the owner, I can add a device by typing the token or scanning a QR code so that setup on a phone is quick.
- As the owner, I can see all devices (name, created, last seen) and revoke one so that a lost device stops working.
- As the owner, I can see which device started, messaged or stopped each session so that I have an audit trail.
- As the owner, I can use the dashboard from my phone with full control, the same as at the PC.

## Acceptance criteria
- [ ] In LAN mode, a request without a valid device token (page, API and live events) is refused.
- [ ] The PC (localhost) can create a device token by giving it a name; the token is shown once.
- [ ] The device list shows each device's name, created date and last-seen time.
- [ ] A device can sign in by entering its token, or by scanning a QR code shown on the PC; a QR code works only once.
- [ ] A signed-in device can do everything the PC can: view state, start commands, message and stop sessions.
- [ ] Revoking a device ends its signed-in session immediately and its token no longer works.
- [ ] The old single shared token no longer works once this ships.
- [ ] Each command or session action in the audit log records the device name that made it.
- [ ] The audit log can be viewed in the dashboard, filtered by device.
- [ ] Device tokens never expire; they stop working only when revoked.
- [ ] A failed sign-in attempt on the LAN raises a needs-attention alert (same alert mechanism as F-001) showing the time and the source address.
- [ ] Adding HTTPS/remote access later does not require changing the device token model (owner to confirm how this is checked; see open questions).

## Out of scope
- Internet or outside-network access.
- Multiple user accounts and roles; passwords or social login.
- Read-only or per-token permission scopes.

## Open questions
- "Ready for outside access later" is a design goal, not a testable behaviour. Is a note in the design enough?
- Answered by owner: devices do not expire (revoke only); failed LAN sign-ins do alert the owner.

## Questions from lead
