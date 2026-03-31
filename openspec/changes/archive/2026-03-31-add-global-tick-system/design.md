# Design: Global Tick System

## Context
LÖVE 2D calls `love.update(dt)` every frame; `dt` is seconds since the last frame (typically ~0.016 s at 60 fps). Game logic that runs "once per second" must accumulate `dt` until a threshold is crossed. This design describes a single, shared accumulator with a pub-sub listener table — the simplest pattern that satisfies idle-game requirements.

## Goals / Non-Goals
- **Goals:** Consistent tick interval across all systems; zero duplication of accumulator logic; easy subscribe/unsubscribe from any module; survives scene transitions.
- **Non-Goals:** Multiple simultaneous tick rates (can be layered on top later); networked synchronization; save/restore of tick count on load.

## Decisions

### Decision: Pub-sub listener table (not event bus, not coroutines)
Lua tables of functions are idiomatic, zero-dependency, and trivially debugged. A listener is a plain function reference; unsubscribing removes it by identity. This is the minimum viable pattern and avoids introducing an event-bus abstraction before it is needed.

**Alternatives considered:**
- *Signal/event-bus library* — adds a dependency or boilerplate; not warranted yet.
- *Coroutines* — powerful but opaque for future contributors; overkill for a simple heartbeat.

### Decision: `while elapsed >= interval` (not `if`)
A single `if` drops ticks during frame spikes (e.g., GC pause). A `while` loop catches up, preserving tick count integrity. Listeners should be fast; if a listener is expensive, that is a separate concern.

### Decision: Tick runs in `main.lua`, not inside SceneManager
`SceneManager.update` is only called for the active scene; scenes change. Production, entropy, and other idle systems must keep ticking regardless of which scene is active. Placing `Tick.update(dt)` directly in `love.update` — before `scenes.update(dt)` — makes this lifecycle explicit and obvious.

### Decision: `subscribe` returns the function itself as a handle
Callers pass the same function reference to `unsubscribe`. Returning the function makes `local handle = Tick.subscribe(fn)` a natural idiom and requires no extra ID scheme.

## Risks / Trade-offs
- **Listener order is insertion order** — deterministic but not configurable. If ordering matters between systems, we add a priority field later.
- **No error isolation** — an error in one listener aborts all subsequent listeners in that tick. Acceptable for now; can wrap in `pcall` if needed.

## Open Questions
- What default interval? **1.0 second** is assumed; should be easy to change via a parameter to a future `Tick.init(interval)` call.
- Should tick count reset on scene switch? **No** — tick count is a global monotonic counter.
