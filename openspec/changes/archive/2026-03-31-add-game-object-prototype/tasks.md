## 1. Slider widget
- [x] 1.1 Create `src/ui/slider.lua` with `draw(x, y, w, label_left, label_right, value)` and
         `handle_x(x, w, value)` helper

## 2. Game object data
- [x] 2.1 Create `src/game_objects.lua` returning a hardcoded list of four object tables
         (red circle, yellow circle, pink box, blue box) with world positions, sliders, and slot fields

## 3. Render objects in viewport
- [x] 3.1 In `game.lua` iterate objects and draw each at `(wx - camera_x, wy)` inside the viewport scissor
- [x] 3.2 Draw circles as filled circles with a white outline; boxes as filled rectangles with a white outline
- [x] 3.3 Draw each box's slot indicator (grey outlined circle at top-right corner, or filled with assigned colour)

## 4. Selection
- [x] 4.1 In `game.lua` `mousepressed`: translate screen → world coords, hit-test all objects
- [x] 4.2 Set `selected` to hit object or nil; ignore clicks inside card tray and config panel regions

## 5. Config panel
- [x] 5.1 Create `src/ui/config_panel.lua` with `draw(selected_object, tray_y)` — renders panel background
         and calls `Slider.draw` for each of the object's sliders
- [x] 5.2 In `game.lua` track `slider_drag = { slider_ref, nil }` state
- [x] 5.3 On `mousepressed` inside panel region, hit-test slider handles and begin drag
- [x] 5.4 On `mousemoved`, update dragged slider value from mouse x
- [x] 5.5 On `mousereleased`, clear slider drag

## 6. Drag-to-slot
- [x] 6.1 On `mousepressed` hitting a circle, set `drag = { object, sx, sy }`
- [x] 6.2 On `mousemoved` while dragging, update `drag.sx/sy`
- [x] 6.3 On `mousereleased`, translate screen → world, hit-test box slot zones (16px radius);
         if hit: displace previous occupant, assign dragged circle; else cancel
- [x] 6.4 Draw drag ghost (same colour circle, semi-transparent) at cursor when drag is active

## 7. Scroll suppression
- [x] 7.1 Pass `drag ~= nil` flag to `viewport:update`; skip edge-scroll when true
