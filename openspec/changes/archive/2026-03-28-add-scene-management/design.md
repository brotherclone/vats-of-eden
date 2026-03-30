# Design: Scene Management

## Context
LÖVE routes all game logic through top-level callbacks (`love.load`, `love.update`, `love.draw`, `love.keypressed`). There is currently one scene (`src/game.lua`) wired directly in `main.lua`. We need a lightweight pattern that lets multiple scenes coexist without duplicating callback wiring.

## Goals / Non-Goals
- Goals: simple scene stack/swap, one active scene at a time, clean transitions
- Non-Goals: animated transitions, persistent scene state across swaps, save/load

## Decisions
- **Scene manager as a table with `switch(name)`, `update(dt)`, `draw()`, `keypressed(key)`**: delegates to the active scene. Scenes register themselves by name.
- **Scenes as modules** under `src/scenes/` (e.g., `load.lua`, `setup.lua`, `game.lua`), each returning a table with `load`, `update`, `draw`, `keypressed`.
- **Button as a plain table** in `src/ui/button.lua` with `new(x, y, w, h, label)`, `draw()`, `update(mx, my)`, `clicked(mx, my)` — no OOP metatable magic needed at this scale.
- **Asset loading in load scene**: uses `love.timer` or a flag set after `love.load` completes; the Play button is hidden/disabled until ready.

## Risks / Trade-offs
- Single active scene means no UI overlays on top of another scene — the ESC overlay in the game scene is rendered *within* the game scene itself (not a separate scene).

## Open Questions
- None at this stage.
