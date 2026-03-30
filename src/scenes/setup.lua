local Button = require("src.ui.button")
local scenes = require("src.scene_manager")

local setup_scene = {}

local play_btn

local W, H = 1280, 720
local BTN_W, BTN_H = 200, 50

function setup_scene.load()
  play_btn = Button.new((W - BTN_W) / 2, (H - BTN_H) / 2, BTN_W, BTN_H, "Play")
end

function setup_scene.update(dt) end

function setup_scene.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.printf("Setup", 0, H / 2 - 60, W, "center")
  play_btn:draw()
end

function setup_scene.mousepressed(x, y, button)
  if button == 1 and play_btn:clicked(x, y) then
    scenes.switch("game")
  end
end

return setup_scene
