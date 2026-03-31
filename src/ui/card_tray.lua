local CardTray = {}
CardTray.__index = CardTray

local SCREEN_H        = 720
local TRAY_W          = 1280
local TRAY_H_COLLAPSED = 140
local TRAY_H_EXPANDED  = 260
local ANIM_DURATION   = 0.5

local CARD_W_BASE = 80
local CARD_H_BASE = 110
local NUM_CARDS   = 3

local function ease(t)
  if t < 0.5 then
    return 2 * t * t
  else
    local f = -2 * t + 2
    return 1 - f * f / 2
  end
end

---@return table
function CardTray.new()
  return setmetatable({
    progress = 0,   -- linear 0=collapsed, 1=expanded
    target   = 0,
  }, CardTray)
end

-- Returns current tray y (top edge), derived from animated height
function CardTray:get_tray_y()
  local h = TRAY_H_COLLAPSED + (TRAY_H_EXPANDED - TRAY_H_COLLAPSED) * ease(self.progress)
  return SCREEN_H - h
end

---@param dt number
function CardTray:update(dt)
  local dir = self.target - self.progress
  if dir ~= 0 then
    local step = dt / ANIM_DURATION
    if math.abs(dir) <= step then
      self.progress = self.target
    else
      self.progress = self.progress + (dir > 0 and step or -step)
    end
  end
end

---@param x number
---@param y number
function CardTray:mousepressed(x, y)
  local tray_y = self:get_tray_y()
  if y >= tray_y then
    self.target = 1
  else
    self.target = 0
  end
end

---@param x number
---@param y number
function CardTray:mousemoved(x, y)
  if self.target == 1 or self.progress > 0 then
    local tray_y = self:get_tray_y()
    if y < tray_y then
      self.target = 0
    end
  end
end

function CardTray:draw()
  local eased     = ease(self.progress)
  local tray_h    = TRAY_H_COLLAPSED + (TRAY_H_EXPANDED - TRAY_H_COLLAPSED) * eased
  local tray_y    = SCREEN_H - tray_h
  local scale     = tray_h / TRAY_H_COLLAPSED
  local card_w    = CARD_W_BASE * scale
  local card_h    = CARD_H_BASE * scale

  -- Tray background
  love.graphics.setColor(0.1, 0.1, 0.15)
  love.graphics.rectangle("fill", 0, tray_y, TRAY_W, tray_h)

  -- Three evenly-spaced placeholder cards
  local spacing = TRAY_W / (NUM_CARDS + 1)
  for i = 1, NUM_CARDS do
    local cx = spacing * i - card_w / 2
    local cy = tray_y + (tray_h - card_h) / 2
    love.graphics.setColor(0.25, 0.25, 0.35)
    love.graphics.rectangle("fill", cx, cy, card_w, card_h, 4, 4)
    love.graphics.setColor(0.5, 0.5, 0.65)
    love.graphics.rectangle("line", cx, cy, card_w, card_h, 4, 4)
  end

  love.graphics.setColor(1, 1, 1)
end

return CardTray
