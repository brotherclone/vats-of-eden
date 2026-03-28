local Button = {}
Button.__index = Button

---@param x number
---@param y number
---@param w number
---@param h number
---@param label string
---@return table
function Button.new(x, y, w, h, label)
  return setmetatable({ x = x, y = y, w = w, h = h, label = label }, Button)
end

function Button:draw()
  love.graphics.setColor(0.2, 0.2, 0.2)
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
  love.graphics.setColor(0.8, 0.8, 0.8)
  love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
  love.graphics.setColor(1, 1, 1)
  love.graphics.printf(self.label, self.x, self.y + self.h / 2 - 7, self.w, "center")
end

---@param mx number
---@param my number
---@return boolean
function Button:clicked(mx, my)
  return mx >= self.x and mx <= self.x + self.w
     and my >= self.y and my <= self.y + self.h
end

return Button
