# Change: Add colony viewport with horizontal scrolling and card tray

## Why
The game scene is currently a blank canvas. This change introduces the two primary visual regions of the game: a horizontally-scrollable colony view and a card tray below it.

## What Changes
- Add a colony viewport occupying the upper region of the game scene (1280×580px), rendering a world 3× the viewport width (3840px wide) with hard left/right scroll boundaries
- Scrolling is triggered by mouse proximity to the left/right viewport edge or by the left/right arrow keys
- Add a card tray in the lower region (1280×140px) displaying three placeholder card slots
- Both systems live inside `src/scenes/game.lua` (viewport) and new modules `src/colony_viewport.lua` / `src/ui/card_tray.lua`

## Impact
- Affected specs: colony-viewport (new), card-tray (new)
- Affected code: `src/scenes/game.lua` (wires both modules into update/draw/keypressed/mousemoved)
