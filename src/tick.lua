---
--- Global tick system — fires registered listeners at a fixed interval.
--- Driven by love.update(dt) in main.lua.
---

local Tick = {}

Tick.interval  = 1.0   -- seconds per tick
Tick._elapsed  = 0
Tick._count    = 0
Tick._listeners = {}

---Register a callback to be called on every tick.
---@param fn function  receives the tick count as its sole argument
---@return function    the same fn, usable as an unsubscribe handle
function Tick.subscribe(fn)
  table.insert(Tick._listeners, fn)
  return fn
end

---Remove a previously registered callback. No-op if fn was never subscribed.
---@param fn function
function Tick.unsubscribe(fn)
  for i, listener in ipairs(Tick._listeners) do
    if listener == fn then
      table.remove(Tick._listeners, i)
      return
    end
  end
end

---Advance the accumulator. Call this from love.update(dt).
---@param dt number  seconds since last frame
function Tick.update(dt)
  Tick._elapsed = Tick._elapsed + dt
  while Tick._elapsed >= Tick.interval do
    Tick._elapsed = Tick._elapsed - Tick.interval
    Tick._count   = Tick._count + 1
    for _, fn in ipairs(Tick._listeners) do
      fn(Tick._count)
    end
  end
end

return Tick
