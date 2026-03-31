## 1. Core Module
- [x] 1.1 Create `src/tick.lua` with `_listeners`, `_elapsed`, `_count`, and `interval` fields
- [x] 1.2 Implement `Tick.subscribe(fn)` — appends to listener table, returns `fn`
- [x] 1.3 Implement `Tick.unsubscribe(fn)` — removes by function identity, no-op if not found
- [x] 1.4 Implement `Tick.update(dt)` — accumulates dt, fires listeners in a `while` loop, increments `_count`

## 2. Integration
- [x] 2.1 `require` the tick module in `main.lua`
- [x] 2.2 Call `Tick.update(dt)` at the top of `love.update`, before `scenes.update(dt)`

## 3. Smoke Test
- [x] 3.1 Add a temporary `print` subscriber in `src/scenes/game.lua` that prints the tick count, verify it fires once per second in-game, then remove it
