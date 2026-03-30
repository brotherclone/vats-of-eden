local Slider = {}

local TRACK_H    = 6
local HANDLE_R   = 10
local LABEL_PAD  = 8

---@param x number  left edge of track
---@param y number  vertical centre of track
---@param w number  track width
---@param value number  0-1
---@return number  screen x of handle centre
function Slider.handle_x(x, w, value)
  return x + value * w
end

---@param x number
---@param y number
---@param w number
---@param label_left string
---@param label_right string
---@param value number  0-1
function Slider.draw(x, y, w, label_left, label_right, value)
  local hx = Slider.handle_x(x, w, value)

  -- Track
  love.graphics.setColor(0.3, 0.3, 0.4)
  love.graphics.rectangle("fill", x, y - TRACK_H / 2, w, TRACK_H, 3, 3)

  -- Fill left of handle
  love.graphics.setColor(0.55, 0.55, 0.75)
  love.graphics.rectangle("fill", x, y - TRACK_H / 2, hx - x, TRACK_H, 3, 3)

  -- Handle
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", hx, y, HANDLE_R)
  love.graphics.setColor(0.4, 0.4, 0.6)
  love.graphics.circle("line", hx, y, HANDLE_R)

  -- Labels
  love.graphics.setColor(0.8, 0.8, 0.8)
  love.graphics.print(label_left,  x - LABEL_PAD - love.graphics.getFont():getWidth(label_left), y - 7)
  love.graphics.print(label_right, x + w + LABEL_PAD, y - 7)

  love.graphics.setColor(1, 1, 1)
end

--- Returns track-relative hit: true if (mx, my) is within the interactive area
---@param x number  track left
---@param y number  track centre y
---@param w number  track width
---@param mx number
---@param my number
---@return boolean
function Slider.hit(x, y, w, mx, my)
  return mx >= x - HANDLE_R and mx <= x + w + HANDLE_R
     and my >= y - HANDLE_R * 2 and my <= y + HANDLE_R * 2
end

--- Clamp mouse x to a 0-1 slider value
---@param x number  track left
---@param w number  track width
---@param mx number
---@return number
function Slider.value_from_x(x, w, mx)
  return math.max(0, math.min(1, (mx - x) / w))
end

return Slider
