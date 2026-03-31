## Context
Objects live in world space (scrollable, x up to 3840). All mouse events arrive in
screen space. The config panel and card tray live in screen space. Drag-and-drop must
bridge both spaces.

## Goals / Non-Goals
- Goals: selection, slider UI, drag-to-slot assignment, all wired into game.lua
- Non-Goals: stat propagation, persistence, dynamic object creation, animations on objects

## Decisions

### Coordinate translation
- World x = screen x + camera_x (from ColonyViewport)
- ColonyViewport exposes `camera_x` as a readable field (already present)
- game.lua translates mouse coords before hit-testing objects

### Object data (`src/game_objects.lua`)
Returns a pre-built list of object tables. Each object has:
```
{ kind, color, wx, wy, radius/w/h, sliders, slot, assigned }
```
- `kind`: "circle" | "box"
- `sliders`: array of `{ label_left, label_right, value }`  (value 0–1)
- `slot`: boxes only — `{ wx, wy, assigned }` (assigned = object ref or nil)
No OOP; plain tables iterated in game.lua.

### Slider widget (`src/ui/slider.lua`)
Stateless draw function + hit-test helper.
```lua
Slider.draw(x, y, w, label_left, label_right, value)
Slider.hit(x, y, w, mx, my)  -- returns new value if dragging handle, else nil
```
Drag state (which slider is being dragged) lives in game.lua, not in the slider.

### Config panel (`src/ui/config_panel.lua`)
Fixed screen rect: x=0, y=tray_y-PANEL_H, w=1280, h=PANEL_H (120px).
Draws only when an object is selected. Receives the selected object table and
current tray_y. Purely a draw module — interaction handled in game.lua.

### Drag and drop
State in game.lua:
```
drag = { object, screen_x, screen_y }  or nil
```
- `mousepressed` on a circle (world hit-test) → set drag
- `mousemoved` → update drag.screen_x/y
- `mousereleased` → world hit-test box slots; if hit, assign; clear drag
Ghost: draw dragged circle at current screen pos (no world offset needed — it follows cursor).

### Slot hit zone
Each box has one slot rendered as a small circle on its top-right corner (world space).
Hit radius: 16px. World position: `(box.wx + box.w - 16, box.wy + 16)`.

## Risks / Trade-offs
- Dragging a world object while the viewport is scrolling could feel odd — scroll is
  suppressed while a drag is active (easy: skip edge-scroll update when drag ~= nil).
- Config panel overlaps upper part of card tray area — acceptable for prototype.

## Open Questions
- None blocking this prototype.
