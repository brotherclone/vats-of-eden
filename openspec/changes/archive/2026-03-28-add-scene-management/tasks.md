# Tasks: add-scene-management

## 1. Foundation
- [x] 1.1 Create `src/ui/button.lua` — Button component with `new`, `draw`, `update`, `clicked`
- [x] 1.2 Create `src/scene_manager.lua` — `register(name, scene)`, `switch(name)`, `update(dt)`, `draw()`, `keypressed(key)`

## 2. Scenes
- [x] 2.1 Create `src/scenes/load.lua` — tracks asset loading state, shows button when ready
- [x] 2.2 Create `src/scenes/setup.lua` — shows Play button, transitions to game on click
- [x] 2.3 Create `src/scenes/game.lua` — game runtime; ESC toggles overlay with Exit button back to setup

## 3. Wiring
- [x] 3.1 Update `main.lua` to register all scenes and delegate LÖVE callbacks to scene manager
- [x] 3.2 Remove or repurpose `src/game.lua` (logic superseded by `src/scenes/game.lua`)

## 4. Validation
- [ ] 4.1 Manually verify load screen button appears and transitions to setup
- [ ] 4.2 Manually verify Play button transitions to game
- [ ] 4.3 Manually verify ESC shows overlay, Exit returns to setup
