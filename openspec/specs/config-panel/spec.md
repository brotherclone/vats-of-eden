# config-panel Specification

## Purpose
TBD - created by archiving change add-game-object-prototype. Update Purpose after archive.
## Requirements
### Requirement: Config Panel
When a game object is selected the game scene SHALL display a config panel fixed to
the screen at y = tray_y − 120, w = 1280, h = 120. The panel SHALL render the selected
object's sliders with left and right pole labels and a draggable handle. The panel SHALL
be hidden when no object is selected.

#### Scenario: Panel appears on selection
- **WHEN** a game object is selected
- **THEN** the config panel renders just above the card tray

#### Scenario: Panel hidden with no selection
- **WHEN** no object is selected
- **THEN** the config panel is not drawn

#### Scenario: Sliders display correct labels
- **WHEN** the config panel renders for an object
- **THEN** each slider shows its left label, right label, and handle at the current value

#### Scenario: Dragging a slider handle updates its value
- **WHEN** the player presses and drags within a slider's track
- **THEN** the handle follows the mouse horizontally and the value updates to [0, 1]

#### Scenario: Panel updates when selection changes
- **WHEN** the player clicks a different object
- **THEN** the config panel immediately shows the new object's sliders

