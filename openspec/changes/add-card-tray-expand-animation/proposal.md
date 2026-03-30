# Change: Add card tray expand/collapse animation

## Why
Cards in the collapsed tray (140px) are small. Clicking the tray expands it to 260px
with an eased animation so the player can read cards clearly, then collapses when
focus moves away — restoring screen space to the colony viewport.

## What Changes
- `CardTray` gains an expand/collapse state driven by a 0→1 progress value animated
  over 500ms using a cubic ease-in-out
- Expanded height: 260px; collapsed height: 140px (unchanged)
- Card dimensions scale proportionally with tray height
- Tray expands on click anywhere within its bounds; collapses when mouse leaves the
  tray region or a click lands outside it
- `ColonyViewport` accepts a dynamic top-boundary height so it always fills the
  remaining screen above the tray (viewport_h = 720 − tray_current_h)
- `game.lua` passes the tray's animated height to the viewport each frame

## Impact
- Affected specs: card-tray (MODIFIED), colony-viewport (MODIFIED)
- Affected code: `src/ui/card_tray.lua`, `src/colony_viewport.lua`,
  `src/scenes/game.lua`
