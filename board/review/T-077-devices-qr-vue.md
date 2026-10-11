---
id: T-077
repo: claude-dashboard
owner: eng-claude-dashboard
brief:                    # none: decision 0007, step 3
depends_on: [T-076]
contracts: []
labels: [auth]
budget_usd: 3
review_rounds: 0
user_ok: true             # user approved every sprint-10 ticket up front, 2026-10-11
pr: https://github.com/chrisfaber95/claude-dashboard/pull/93
---
## Goal
QR pairing is a Vue component, and the QR library loads only when a QR code is shown.

## Acceptance
- [ ] `features/devices/pairing-qr.vue` replaces `devices-qr.view.ts`: same QR, expiry, note and Close behaviour
- [ ] `qrcode-generator` is loaded with `import()` on first use; the build puts it in its own chunk, not the main bundle (sizes in the hand-off)
- [ ] `devices-qr.view.ts` deleted; component test covers show, expiry text and close (QR drawing may be stubbed)
- [ ] Template is normally indented HTML inside the `.vue` file; no `v-html`, `any`, `as` (except `as const`) or `!`; deleted files leave `TYPE_SAFETY_LEGACY_FILES` in `eslint.config.js`
- [ ] `npm run typecheck`, `npm run lint` and `npm test` pass; new behavior has a test; new and changed code follows `docs/code-style.md` (decision 0006)

## Notes (lead)
- `auth` (pairing, T-011/T-024). Decision 0007 names the lazy load. The QR is drawn from data, no `innerHTML`.
- Copy the "Vue panel" section of `docs/code-style.md` (limits panel, T-052). Use the vendored `vue-best-practices` and `vue-testing-best-practices` skills.
- No browser in the run: list in the hand-off what the user should look at (skins Classic, Co-pilot, Root; light and dark).

## Hand-off (engineer writes, max 300 tokens)
PR #93: pairing QR is now `features/devices/pairing-qr.vue`; `devices-qr.view.ts` deleted. `devices-panel.vue` holds the pairing in a ref and renders the component (name, expiry text, no-LAN note, address select, Close, expiry timer). The component loads `qr.logic.ts` with `import()` on first draw, so `qrcode-generator` is its own chunk: `qr.logic-*.js` 20.84 kB (gzip 7.41 kB); main `index-*.js` 149.50 kB. SVG drawn from data in the template, no `v-html`. Tests: new `pairing-qr.component.spec.ts`; panel spec uses the real component. typecheck, lint, test (471 node + 101 vitest) and build pass locally.

Reviewer: CI not yet confirmed; code-reviewer pass not run (reviewer does it). No browser in this run: user should check the QR panel in skins Classic, Co-pilot, Root, light and dark (show, address select with several LAN addresses, expiry, Close). Commit trailer is plain "Claude" per memory rule.

## Review (reviewer writes, one line per round)
