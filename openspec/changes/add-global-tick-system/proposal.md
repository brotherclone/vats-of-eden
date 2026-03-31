# Change: Add Global Tick System

## Why
Idle-game mechanics (production, entropy, resource decay) all require a shared heartbeat that fires at a predictable interval, independent of frame rate. Without a centralized tick, each system would have to implement its own accumulator — leading to drift, duplication, and inconsistent pacing.

## What Changes
- Add `src/tick.lua` — a new module that owns the accumulator, fires callbacks at a configured interval, and exposes `subscribe`/`unsubscribe`/`update`.
- Wire `Tick.update(dt)` into `main.lua`'s `love.update` at the top level (not inside a scene) so ticks survive scene transitions.
- No existing modules are modified beyond `main.lua`.

## Impact
- Affected specs: `tick-system` (new capability)
- Affected code: `main.lua` (one `require` and one call added to `love.update`)
