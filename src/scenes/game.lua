local Button       = require("src.ui.button")
local scenes       = require("src.scene_manager")

local ColonyViewport = require("src.colony_viewport")
local CardTray     = require("src.ui.card_tray")
local ConfigPanel  = require("src.ui.config_panel")
local Slider       = require("src.ui.slider")
local GameObjects  = require("src.game_objects")

local game_scene = {}

local W, H = 1280, 720
local BTN_W, BTN_H = 200, 50
local SLOT_R = 16

local overlay_visible = false
local exit_btn
local viewport
local card_tray
local objects

local selected    = nil   -- selected game object
local slider_drag = nil   -- { slider_table, panel_x, panel_w }
local drag        = nil   -- { object, sx, sy }

-- ── helpers ────────────────────────────────────────────────────────────────

local function world_to_screen_x(wx) return wx - viewport.camera_x end
local function screen_to_world_x(sx) return sx + viewport.camera_x end

local function hit_circle(obj, wx, wy)
  local dx = wx - obj.wx
  local dy = wy - obj.wy
  return dx * dx + dy * dy <= obj.radius * obj.radius
end

local function hit_box(obj, wx, wy)
  return wx >= obj.wx and wx <= obj.wx + obj.w
     and wy >= obj.wy and wy <= obj.wy + obj.h
end

local function hit_slot(box, wx, wy)
  local s  = box.slot
  local dx = wx - s.wx
  local dy = wy - s.wy
  return dx * dx + dy * dy <= SLOT_R * SLOT_R
end

local function find_object_at(wx, wy)
  for _, obj in ipairs(objects) do
    if obj.kind == "circle" and hit_circle(obj, wx, wy) then return obj end
    if obj.kind == "box"    and hit_box(obj, wx, wy)    then return obj end
  end
  return nil
end

-- ── lifecycle ──────────────────────────────────────────────────────────────

function game_scene.load()
  overlay_visible = false
  exit_btn  = Button.new((W - BTN_W) / 2, (H - BTN_H) / 2, BTN_W, BTN_H, "Exit")
  viewport  = ColonyViewport.new()
  card_tray = CardTray.new()
  objects   = GameObjects.build()
  selected  = nil
  drag      = nil
  slider_drag = nil
end

function game_scene.update(dt)
  card_tray:update(dt)
  local viewport_h = card_tray:get_tray_y()
  viewport:update(dt, viewport_h, drag ~= nil)
end

-- ── draw ───────────────────────────────────────────────────────────────────

local function draw_objects(viewport_h)
  love.graphics.push()
  love.graphics.setScissor(0, 0, W, viewport_h)
  love.graphics.translate(-viewport.camera_x, 0)

  for _, obj in ipairs(objects) do
    -- Skip the dragged circle (draw it as ghost instead)
    local is_dragged = drag and drag.object == obj

    if obj.kind == "circle" and not is_dragged then
      love.graphics.setColor(obj.color)
      love.graphics.circle("fill", obj.wx, obj.wy, obj.radius)
      love.graphics.setColor(1, 1, 1)
      love.graphics.circle("line", obj.wx, obj.wy, obj.radius)

    elseif obj.kind == "box" then
      love.graphics.setColor(obj.color)
      love.graphics.rectangle("fill", obj.wx, obj.wy, obj.w, obj.h, 6, 6)
      love.graphics.setColor(1, 1, 1)
      love.graphics.rectangle("line", obj.wx, obj.wy, obj.w, obj.h, 6, 6)

      -- Slot indicator
      local s = obj.slot
      if s.assigned then
        love.graphics.setColor(s.assigned.color)
        love.graphics.circle("fill", s.wx, s.wy, SLOT_R)
      else
        love.graphics.setColor(0.45, 0.45, 0.45)
        love.graphics.circle("fill", s.wx, s.wy, SLOT_R)
      end
      love.graphics.setColor(1, 1, 1)
      love.graphics.circle("line", s.wx, s.wy, SLOT_R)
    end
  end

  -- Selection ring
  if selected then
    love.graphics.setColor(1, 1, 0.3, 0.9)
    if selected.kind == "circle" then
      love.graphics.circle("line", selected.wx, selected.wy, selected.radius + 4)
    else
      love.graphics.rectangle("line",
        selected.wx - 4, selected.wy - 4,
        selected.w  + 8, selected.h  + 8, 8, 8)
    end
  end

  love.graphics.pop()
  love.graphics.setScissor()
end

local function draw_drag_ghost()
  if not drag then return end
  local obj = drag.object
  love.graphics.setColor(obj.color[1], obj.color[2], obj.color[3], 0.65)
  love.graphics.circle("fill", drag.sx, drag.sy, obj.radius)
  love.graphics.setColor(1, 1, 1, 0.65)
  love.graphics.circle("line", drag.sx, drag.sy, obj.radius)
  love.graphics.setColor(1, 1, 1)
end

function game_scene.draw()
  local tray_y     = card_tray:get_tray_y()
  local viewport_h = tray_y

  viewport:draw(viewport_h)
  draw_objects(viewport_h)
  card_tray:draw()
  ConfigPanel.draw(selected, tray_y)
  draw_drag_ghost()

  if overlay_visible then
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 0, 0, W, H)
    exit_btn:draw()
  end
end

-- ── input ──────────────────────────────────────────────────────────────────

function game_scene.keypressed(key)
  if key == "escape" then
    overlay_visible = not overlay_visible
  end
end

function game_scene.mousemoved(x, y)
  viewport:mousemoved(x, y)
  card_tray:mousemoved(x, y)
  if drag then
    drag.sx = x
    drag.sy = y
  end
  if slider_drag then
    local sl = slider_drag.slider
    sl.value = Slider.value_from_x(slider_drag.track_x, slider_drag.track_w, x)
  end
end

function game_scene.mousereleased(x, y, button)
  if button ~= 1 then return end

  -- Finish slider drag
  slider_drag = nil

  -- Finish object drag: hit-test slot zones
  if drag then
    local wx = screen_to_world_x(x)
    local wy = y
    for _, obj in ipairs(objects) do
      if obj.kind == "box" and hit_slot(obj, wx, wy) then
        -- Displace previous occupant
        if obj.slot.assigned then
          obj.slot.assigned = nil
        end
        obj.slot.assigned = drag.object
        break
      end
    end
    drag = nil
  end
end

function game_scene.mousepressed(x, y, button)
  if button ~= 1 then return end

  -- Overlay exit button
  if overlay_visible then
    if exit_btn:clicked(x, y) then scenes.switch("setup") end
    return
  end

  local tray_y   = card_tray:get_tray_y()
  local panel_y  = ConfigPanel.panel_y(tray_y)

  -- Card tray click
  if y >= tray_y then
    card_tray:mousepressed(x, y)
    return
  end

  -- Config panel slider hit
  if selected and y >= panel_y then
    local mid_y = panel_y + 60
    local rects = ConfigPanel.slider_rects(selected)
    for i, sl in ipairs(selected.sliders) do
      local r = rects[i]
      if Slider.hit(r.x, mid_y, r.w, x, y) then
        slider_drag = { slider = sl, track_x = r.x, track_w = r.w }
        sl.value = Slider.value_from_x(r.x, r.w, x)
        return
      end
    end
    return
  end

  -- Viewport click: hit-test world objects
  local wx = screen_to_world_x(x)
  local wy = y

  -- Check circles first (drag source)
  for _, obj in ipairs(objects) do
    if obj.kind == "circle" and hit_circle(obj, wx, wy) then
      selected = obj
      drag = { object = obj, sx = x, sy = y }
      return
    end
  end

  -- Check boxes
  for _, obj in ipairs(objects) do
    if obj.kind == "box" and hit_box(obj, wx, wy) then
      selected = obj
      return
    end
  end

  -- Missed everything — deselect
  selected = nil
end

return game_scene
