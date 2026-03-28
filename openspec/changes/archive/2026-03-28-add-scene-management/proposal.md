# Change: Add scene management and UI buttons

## Why
The game currently runs as a single monolithic state with no way to navigate between screens. A structured scene system and reusable button component are needed to support the full player flow from loading through to gameplay.

## What Changes
- Introduce a scene manager that drives transitions between named scenes
- Add a `load` scene: displays a button once assets finish loading; clicking advances to `setup`
- Add a `setup` scene: displays a Play button; clicking starts the `game` scene
- Add a `game` scene: no UI initially; pressing ESC toggles an overlay with an Exit button that returns to `setup`
- Add a reusable `Button` UI component used across all scenes

## Impact
- Affected specs: `scene-management`, `button-ui`
- Affected code: `main.lua`, `src/game.lua` (replaced by scene system), new files under `src/scenes/` and `src/ui/`
