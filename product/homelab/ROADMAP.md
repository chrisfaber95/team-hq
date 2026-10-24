# Roadmap

Approved briefs in priority order (must, then should, then could). The designer adds a line when
the user approves a brief; the lead marks it handed off once its tickets exist.

## Planned
- [F-016](briefs/F-016-headless-homelab-base.md) Headless homelab base: Ubuntu, GPU, private access, Claude Code (must). Built by the user + Claude on the box, not the team.
- [F-017](briefs/F-017-llm-helper.md) Local LLM helper: summarize and extract over the tailnet (must; after F-016). Built by the user + Claude on the box, not the team.
- [F-018](briefs/F-018-projects-and-auto-sync.md) Projects on the box: repo sync, auto-deploy on main, Docker and dev clones (must; after F-016). Built by the user + Claude on the box, not the team.
- [F-019](briefs/F-019-claude-machine-changes.md) Claude makes machine changes: instant allowlist, approve-by-PR, auto-revert (must; after F-016 and F-018). Built by the user + Claude on the box, not the team.
- [F-020](briefs/F-020-health-alerts-and-backups.md) Health alerts, one overview, and backups of what the repo can't rebuild (should; after F-016 and F-019). Built by the user + Claude on the box, not the team.
- [F-021](briefs/F-021-claude-task-inbox.md) Claude task inbox: send Claude on the box a task from the phone, PR or answer back (should; after F-016 and F-018, uses F-019 and F-020). Built by the user + Claude on the box, not the team.
