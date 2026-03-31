# Change: Add game object config prototype

## Why
Establishes the core interaction loop: world objects have configurable sliders and can
accept other objects into their slots. This prototype uses four hardcoded objects so
the full interaction — selection, slider config, and drag-to-assign — can be validated
before generalising to dynamic game data.

## What Changes
- Four hardcoded objects placed in world space within the colony viewport:
  - Red circle (agent): 1 slider — "Speed ↔ Discipline"
  - Yellow circle (agent): 1 slider — "Strength ↔ Precision"
  - Pink box (building): 1 slider — "Input ↔ Output", 1 slot
  - Blue box (building): 1 slider — "Power ↔ Efficiency", 1 slot
- Clicking any object selects it and opens a config panel fixed just above the card tray
- Config panel renders the selected object's sliders (draggable handles, visual only)
- Boxes render a visible slot on their body; circles can be dragged and dropped into a slot
- One circle per slot; reassigning drops the previous occupant
- Sliders have no stat effects in this prototype

## Impact
- Affected specs: game-objects (new), config-panel (new), slot-assignment (new)
- Affected code: new `src/game_objects.lua`, `src/ui/config_panel.lua`, `src/ui/slider.lua`;
  updated `src/colony_viewport.lua` (coordinate translation), `src/scenes/game.lua`
