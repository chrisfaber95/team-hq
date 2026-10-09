# 0003: Per-device LAN tokens, loopback exempt

Date: 2026-10-09. Decided by: the user (loopback exemption, QR library) and the lead (token model), for brief F-002.

## Context

F-002 replaces the single shared LAN token with named, revocable device tokens, sign-in by token or one-time QR, and
an audit trail per device. The PC must be able to create and revoke devices.

## Decision

- **Token model.** A device token is 32 random bytes (base64url), shown once at creation and never stored: the store
  (`DATA_DIR/devices.json`) keeps `id`, `name`, `sha256` of the token, `createdMs`, `lastSeenMs`. Sign-in compares
  hashes timing-safely and creates a cookie session bound to the device id. Revoking a device deletes it, ends its
  sessions and closes its live-event streams. The model depends only on "bearer token -> session cookie", not on the
  transport, so later HTTPS/remote access does not change it (this is how F-002's last criterion is checked).
- **Loopback exemption (user's choice).** In LAN mode a request whose socket `remoteAddress` is loopback **and** whose
  `Host` header is a loopback host needs no token and acts as the device `pc`. Headers like `X-Forwarded-For` are never
  trusted. Only these requests may create, list or revoke devices and create QR codes.
- **No expiry (brief update).** Tokens never expire. A device session slides: each authed request extends it to 7 days
  from now, so an active device stays signed in until revoked.
- **Failed sign-ins (brief update).** Each failed or rate-limited LAN sign-in feeds one F-001 alert per source address
  (`signin:<address>`), open until dismissed and re-opened by a new failure; in memory only, max 50 addresses.
- **Old shared token.** The `DATA_DIR/token` file is no longer read; the server removes it at startup.
- **QR (user's choice).** `qrcode-generator` (MIT, no dependencies), bundled into the client. The QR encodes a URL with
  a single-use pairing code (short-lived), never the device token itself.

## Consequences

- Outside access later must **not** arrive through a reverse proxy or tunnel on the same PC while the loopback
  exemption exists: proxied traffic is loopback and would bypass login. Revisit this decision before any outside access.
- A PC browser that opens the dashboard by its LAN address (not `127.0.0.1`/`localhost`) is not exempt and needs a token.
- Tickets T-008..T-014; all auth tickets need `security-auditor` before the PR and the user's `user_ok` to merge.
