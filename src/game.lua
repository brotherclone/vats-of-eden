local game = {}

function game.load()
end

---@param dt number
function game.update(dt)
end

function game.draw()
end

---@param key string
---@param scancode string
---@param isrepeat boolean
function game.keypressed(key, scancode, isrepeat)
  if key == "escape" then
    love.event.quit()
  end
end

return game
