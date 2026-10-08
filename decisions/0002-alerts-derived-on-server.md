# 0002: Needs-attention alerts are derived on the server

Date: 2026-10-08. Decided by: the lead (technical choice for brief F-001).

## Context

F-001 asks for alerts that never duplicate across SSE refreshes and page reloads, that stay dismissed until their
condition clears and happens again, and a usage threshold that persists. The dashboard can be open on several LAN
devices at once.

## Decision

- The server derives alerts on every state build from data it already has: live sessions with `status === 'waiting'`,
  `limits.windows` at or above the threshold, and `team.active.review`. Each alert has a deterministic id per condition
  (`session:<sessionId>`, `usage:<windowKey>`, `ticket:<T-id>`), so duplicates are impossible by construction.
- Dismissed ids and the threshold live on the server in `DATA_DIR/alerts.json`. A dismissed id is dropped from the
  set as soon as its condition is absent, so the next occurrence alerts again. Dismissals are shared by all devices.
- Alerts reach the browser only as a field of `DashboardState`, behind the existing login and request checks.
- The client toasts an alert only if its id was not in the first state it received after loading, so a reload never
  re-toasts.

## Consequences

- Three tickets: T-005 (derivation + store), T-006 (dismiss and threshold endpoints), T-007 (UI).
- Default threshold 80%, integer 1-100.
- When limits are unavailable (`source: 'none'`), usage dismissals are kept rather than treated as cleared.
