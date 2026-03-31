---
--- Created by gabrielwalsh
--- DateTime: 3/26/26 5:41 PM
---

local scenes = require("src.scene_manager")
local Tick   = require("src.tick")

function love.load()
  scenes.register("load",  require("src.scenes.load"))
  scenes.register("setup", require("src.scenes.setup"))
  scenes.register("game",  require("src.scenes.game"))
  scenes.switch("load")
end

function love.update(dt)
  Tick.update(dt)
  scenes.update(dt)
end

function love.draw()
  scenes.draw()
end

function love.keypressed(key, scancode, isrepeat)
  scenes.keypressed(key, scancode, isrepeat)
end

function love.mousepressed(x, y, button)
  scenes.mousepressed(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
  scenes.mousemoved(x, y, dx, dy)
end

function love.mousereleased(x, y, button)
  scenes.mousereleased(x, y, button)
end
