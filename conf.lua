---
--- Created by gabrielwalsh
--- DateTime: 3/26/26 5:41 PM
---
function love.conf(t)
  t.window.title   = "The Empty Fields"
  t.window.width   = 1280
  t.window.height  = 720
  t.window.vsync   = 1
  t.console        = true   -- Windows only, shows stdout in terminal
  t.modules.joystick = false -- kill modules you don't need
  t.modules.physics  = false -- same — Box2D is built in but irrelevant for RTS
end