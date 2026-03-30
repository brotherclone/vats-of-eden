local M = {}

-- Slot world position relative to box: top-right corner
local function make_slot(box)
  return { wx = box.wx + box.w - 16, wy = box.wy + 16, assigned = nil }
end

function M.build()
  local red = {
    kind   = "circle",
    label  = "Red",
    color  = { 0.85, 0.2, 0.2 },
    wx     = 300, wy = 200, radius = 28,
    sliders = {
      { label_left = "Speed", label_right = "Discipline", value = 0.5 },
    },
  }

  local yellow = {
    kind   = "circle",
    label  = "Yellow",
    color  = { 0.9, 0.8, 0.1 },
    wx     = 520, wy = 200, radius = 28,
    sliders = {
      { label_left = "Strength", label_right = "Precision", value = 0.5 },
    },
  }

  local pink = {
    kind   = "box",
    label  = "Pink",
    color  = { 0.85, 0.4, 0.6 },
    wx     = 780, wy = 160, w = 120, h = 90,
    sliders = {
      { label_left = "Input", label_right = "Output", value = 0.5 },
    },
  }
  pink.slot = make_slot(pink)

  local blue = {
    kind   = "box",
    label  = "Blue",
    color  = { 0.2, 0.5, 0.9 },
    wx     = 1050, wy = 160, w = 120, h = 90,
    sliders = {
      { label_left = "Power", label_right = "Efficiency", value = 0.5 },
    },
  }
  blue.slot = make_slot(blue)

  return { red, yellow, pink, blue }
end

return M
