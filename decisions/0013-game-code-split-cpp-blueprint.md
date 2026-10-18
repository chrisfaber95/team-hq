# 0013: Game code split: C++ core, Blueprints for content

Date: 2026-10-18. Decided by: the user (hybrid), the lead (the split below).

## Context

The engineer started F-009 in C++. The user prefers Blueprints. Blueprint logic is edited through the editor MCP
only, the reviewer sees a lossy DSL text (decision 0010), and `.uasset` files can't be merged.

## Decision

- **C++** (`Source/`): player character, movement, camera, input, settings, damage/health, AI base classes,
  save/load. Anything where feel, timing or testability matters.
- **Blueprints**: level logic (levers, gates, crates, trucks), pickups, enemy variants as children of C++ classes,
  UMG widgets (HUD, menus), maps. C++ classes expose tunables (`EditAnywhere`) and events
  (`BlueprintImplementableEvent` / `BlueprintCallable`) so the Blueprints stay thin.
- Tickets that change Blueprint logic keep `user_check: true` (decision 0010).
- Briefs F-010..F-014 are ticketed with this split; G-001..G-008 (F-009) stay C++ plus one map.

## Consequences

- Engineers add Blueprint-friendly hooks in C++ first; Blueprint tickets follow as separate tickets.
- The user can build and tune content in the editor without waiting for an engineer, outside a ticket's listed assets.
