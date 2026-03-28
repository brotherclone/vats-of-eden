local Button = require("src.ui.button")
local scenes = require("src.scene_manager")

local game_scene = {}

local overlay_visible = false
local exit_btn

local W, H = 1280, 720
local BTN_W, BTN_H = 200, 50

function game_scene.load()
  overlay_visible = false
  exit_btn = Button.new((W - BTN_W) / 2, (H - BTN_H) / 2, BTN_W, BTN_H, "Exit")
end

function game_scene.update(dt) end

function game_scene.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.printf("Game", 0, 40, W, "center")
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

function game_scene.mousepressed(x, y, button)
  if button == 1 and overlay_visible and exit_btn:clicked(x, y) then
    scenes.switch("setup")
  end
end

return game_scene
