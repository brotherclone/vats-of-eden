---
--- Created by gabrielwalsh
--- DateTime: 3/26/26 5:41 PM
---

local game = require("src.game")

function love.load()
  game.load()
end

function love.update(dt)
  game.update(dt)
end

function love.draw()
  game.draw()
end

function love.keypressed(key, scancode, isrepeat)
  game.keypressed(key, scancode, isrepeat)
end
