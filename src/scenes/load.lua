local Button = require("src.ui.button")
local scenes = require("src.scene_manager")

local load_scene = {}

local ready = false
local start_btn

local W, H = 1280, 720
local BTN_W, BTN_H = 200, 50

function load_scene.load()
  ready = false
  start_btn = Button.new((W - BTN_W) / 2, (H - BTN_H) / 2, BTN_W, BTN_H, "Start")
  -- Simulate asset loading completing on next frame via a flag.
  -- Replace this with real asset callbacks when assets exist.
  ready = true
end

function load_scene.update(dt) end

function load_scene.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.printf("Loading...", 0, H / 2 - 60, W, "center")
  if ready then
    start_btn:draw()
  end
end

function load_scene.mousepressed(x, y, button)
  if button == 1 and ready and start_btn:clicked(x, y) then
    scenes.switch("setup")
  end
end

return load_scene
