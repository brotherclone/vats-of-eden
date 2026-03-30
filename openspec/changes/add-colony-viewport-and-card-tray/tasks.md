## 1. Colony Viewport Module
- [x] 1.1 Create `src/colony_viewport.lua` with `new()`, `update(dt)`, `draw()`, `mousemoved(x, y)` interface
- [x] 1.2 Implement camera offset clamped to `[0, world_width - viewport_width]` (0 to 2560)
- [x] 1.3 Implement edge-scroll: move camera when mouse x is within 60px of viewport left/right edge
- [x] 1.4 Implement key-scroll: left/right arrow keys scroll at a fixed speed (pixels/sec)
- [x] 1.5 Draw a placeholder background fill for the colony world (solid colour or grid)

## 2. Card Tray Module
- [x] 2.1 Create `src/ui/card_tray.lua` with `new()` and `draw()` interface
- [x] 2.2 Draw three evenly-spaced placeholder card rectangles in the tray region (1280×140px at y=580)

## 3. Wire into Game Scene
- [x] 3.1 Instantiate `ColonyViewport` and `CardTray` in `game_scene.load()`
- [x] 3.2 Forward `update(dt)` to viewport
- [x] 3.3 Forward `draw()` to viewport then card tray (card tray drawn on top)
- [x] 3.4 Forward `keypressed` to viewport (handled via `love.keyboard.isDown` in update)
- [x] 3.5 Add `mousemoved` to `SceneManager` and `main.lua`, forward to viewport
