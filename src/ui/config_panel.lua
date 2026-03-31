local Slider = require("src.ui.slider")

local ConfigPanel = {}

local PANEL_H      = 120
local TRACK_W      = 260
local SOCKET_ZONE  = 130   -- px reserved on right for slot socket
local SOCKET_R     = 28

-- Returns the screen y of the panel top given current tray_y
function ConfigPanel.panel_y(tray_y)
  return tray_y - PANEL_H
end

-- Returns per-slider layout: array of { x, w } in screen space.
-- For boxes, sliders are constrained to leave room for the socket on the right.
function ConfigPanel.slider_rects(obj)
  local n       = #obj.sliders
  local avail_w = obj.kind == "box" and (1280 - SOCKET_ZONE) or 1280
  local step    = avail_w / n
  local rects   = {}
  for i = 1, n do
    local cx = step * (i - 0.5)
    rects[i] = { x = cx - TRACK_W / 2, w = TRACK_W }
  end
  return rects
end

local function draw_socket(obj, mid_y)
  local sx = 1280 - SOCKET_ZONE / 2
  local assigned = obj.slot.assigned

  -- Socket background ring
  love.graphics.setColor(0.18, 0.18, 0.25)
  love.graphics.circle("fill", sx, mid_y, SOCKET_R + 6)
  love.graphics.setColor(0.4, 0.4, 0.55)
  love.graphics.circle("line", sx, mid_y, SOCKET_R + 6)

  if assigned then
    -- Filled with assigned circle colour
    love.graphics.setColor(assigned.color)
    love.graphics.circle("fill", sx, mid_y, SOCKET_R)
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("line", sx, mid_y, SOCKET_R)
    -- Label below
    love.graphics.setColor(0.85, 0.85, 0.85)
    local lw = love.graphics.getFont():getWidth(assigned.label)
    love.graphics.print(assigned.label, sx - lw / 2, mid_y + SOCKET_R + 8)
  else
    -- Empty socket
    love.graphics.setColor(0.3, 0.3, 0.4)
    love.graphics.circle("fill", sx, mid_y, SOCKET_R)
    love.graphics.setColor(0.55, 0.55, 0.65)
    -- Dashed cross to suggest "empty"
    love.graphics.line(sx - 10, mid_y, sx + 10, mid_y)
    love.graphics.line(sx, mid_y - 10, sx, mid_y + 10)
    love.graphics.setColor(0.5, 0.5, 0.6)
    local lw = love.graphics.getFont():getWidth("empty")
    love.graphics.print("empty", sx - lw / 2, mid_y + SOCKET_R + 8)
  end
end

---@param obj table   selected game object
---@param tray_y number
function ConfigPanel.draw(obj, tray_y)
  if not obj then return end

  local py    = ConfigPanel.panel_y(tray_y)
  local mid_y = py + PANEL_H / 2

  -- Background
  love.graphics.setColor(0.08, 0.08, 0.12, 0.95)
  love.graphics.rectangle("fill", 0, py, 1280, PANEL_H)
  love.graphics.setColor(0.25, 0.25, 0.35)
  love.graphics.rectangle("line", 0, py, 1280, PANEL_H)

  -- Object colour swatch + label
  love.graphics.setColor(obj.color)
  love.graphics.rectangle("fill", 16, py + 16, 24, 24, 3, 3)
  love.graphics.setColor(0.9, 0.9, 0.9)
  love.graphics.print(obj.label, 48, py + 18)

  -- Sliders
  local rects = ConfigPanel.slider_rects(obj)
  for i, sl in ipairs(obj.sliders) do
    Slider.draw(rects[i].x, mid_y, rects[i].w,
                sl.label_left, sl.label_right, sl.value)
  end

  -- Socket (boxes only)
  if obj.kind == "box" then
    draw_socket(obj, mid_y)
  end

  love.graphics.setColor(1, 1, 1)
end

return ConfigPanel
