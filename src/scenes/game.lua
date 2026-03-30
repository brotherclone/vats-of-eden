local Button          = require("src.ui.button")
local scenes          = require("src.scene_manager")
local ColonyViewport  = require("src.colony_viewport")
local CardTray        = require("src.ui.card_tray")

local game_scene = {}

local overlay_visible = false
local exit_btn
local viewport
local card_tray

local W, H = 1280, 720
local BTN_W, BTN_H = 200, 50

function game_scene.load()
  overlay_visible = false
  exit_btn  = Button.new((W - BTN_W) / 2, (H - BTN_H) / 2, BTN_W, BTN_H, "Exit")
  viewport  = ColonyViewport.new()
  card_tray = CardTray.new()
end

function game_scene.update(dt)
  card_tray:update(dt)
  local viewport_h = card_tray:get_tray_y()
  viewport:update(dt, viewport_h)
end

function game_scene.draw()
  local viewport_h = card_tray:get_tray_y()
  viewport:draw(viewport_h)
  card_tray:draw()

  if overlay_visible then
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 0, 0, W, H)
    exit_btn:draw()
  end
end

function game_scene.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    overlay_visible = not overlay_visible
  end
end

function game_scene.mousemoved(x, y, dx, dy)
  viewport:mousemoved(x, y)
  card_tray:mousemoved(x, y)
end

function game_scene.mousepressed(x, y, button)
  if button == 1 then
    if overlay_visible and exit_btn:clicked(x, y) then
      scenes.switch("setup")
    else
      card_tray:mousepressed(x, y)
    end
  end
end

return game_scene
