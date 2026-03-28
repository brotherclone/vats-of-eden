local SceneManager = {}

local scenes = {}
local active = nil

---@param name string
---@param scene table
function SceneManager.register(name, scene)
  scenes[name] = scene
end

---@param name string
function SceneManager.switch(name)
  assert(scenes[name], "Scene not registered: " .. tostring(name))
  active = scenes[name]
  if active.load then active.load() end
end

---@param dt number
function SceneManager.update(dt)
  if active and active.update then active.update(dt) end
end

function SceneManager.draw()
  if active and active.draw then active.draw() end
end

---@param key string
---@param scancode string
---@param isrepeat boolean
function SceneManager.keypressed(key, scancode, isrepeat)
  if active and active.keypressed then active.keypressed(key, scancode, isrepeat) end
end

function SceneManager.mousepressed(x, y, button)
  if active and active.mousepressed then active.mousepressed(x, y, button) end
end

return SceneManager
