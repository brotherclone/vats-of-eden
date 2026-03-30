local ColonyViewport = {}
ColonyViewport.__index = ColonyViewport

local VIEWPORT_W   = 1280
local WORLD_W      = VIEWPORT_W * 3   -- 3840
local SCROLL_SPEED = 400              -- pixels per second
local EDGE_ZONE    = 60

---@return table
function ColonyViewport.new()
  return setmetatable({
    camera_x = 0,
    mouse_x  = 0,
  }, ColonyViewport)
end

---@param x number
---@param y number
function ColonyViewport:mousemoved(x, y)
  self.mouse_x = x
end

---@param dt number
---@param viewport_h number
function ColonyViewport:update(dt, viewport_h)
  local dx = 0
  if love.keyboard.isDown("left")  or self.mouse_x < EDGE_ZONE then
    dx = -SCROLL_SPEED * dt
  end
  if love.keyboard.isDown("right") or self.mouse_x >= VIEWPORT_W - EDGE_ZONE then
    dx = dx + SCROLL_SPEED * dt
  end
  self.camera_x = math.max(0, math.min(self.camera_x + dx, WORLD_W - VIEWPORT_W))
end

---@param viewport_h number
function ColonyViewport:draw(viewport_h)
  love.graphics.push()
  love.graphics.setScissor(0, 0, VIEWPORT_W, viewport_h)

  love.graphics.setColor(0.13, 0.18, 0.13)
  love.graphics.rectangle("fill", 0, 0, VIEWPORT_W, viewport_h)

  love.graphics.translate(-self.camera_x, 0)

  love.graphics.setColor(0.2, 0.28, 0.2)
  for col = 0, WORLD_W, 320 do
    love.graphics.line(col, 0, col, viewport_h)
  end

  love.graphics.pop()
  love.graphics.setScissor()
  love.graphics.setColor(1, 1, 1)
end

return ColonyViewport
