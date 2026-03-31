## 1. CardTray animation state
- [x] 1.1 Add `progress` (0=collapsed, 1=expanded), `target` (0 or 1), and `ANIM_DURATION=0.5` to CardTray
- [x] 1.2 Add `update(dt)` that moves `progress` toward `target` at 1/ANIM_DURATION per second,
         applying cubic ease-in-out when drawing (keep progress linear internally, ease on output)
- [x] 1.3 Expose `get_tray_y()` returning `720 - current_tray_h` so game.lua can pass it to the viewport

## 2. CardTray trigger logic
- [x] 2.1 Add `mousepressed(x, y)` — set `target=1` if click is inside tray bounds, `target=0` otherwise
- [x] 2.2 Add `mousemoved(x, y)` — set `target=0` when mouse leaves tray bounds while expanded

## 3. CardTray draw update
- [x] 3.1 Lerp tray height between TRAY_H_COLLAPSED (140) and TRAY_H_EXPANDED (260) using eased progress
- [x] 3.2 Scale card dimensions proportionally with tray height
- [x] 3.3 Recompute `TRAY_Y = 720 - current_tray_h` each draw so tray grows upward

## 4. ColonyViewport dynamic height
- [x] 4.1 Remove the hard-coded `VIEWPORT_H=580` constant; accept `viewport_h` as a parameter to `update` and `draw`
- [x] 4.2 Clamp edge-scroll mouse detection to the passed `viewport_h`
- [x] 4.3 Apply scissor rect using the passed `viewport_h`

## 5. Wire in game.lua
- [x] 5.1 Forward `mousepressed` and `mousemoved` to card_tray (in addition to existing viewport forwarding)
- [x] 5.2 Pass `card_tray:get_tray_y()` to `viewport:update(dt, tray_y)` and `viewport:draw(tray_y)` each frame
