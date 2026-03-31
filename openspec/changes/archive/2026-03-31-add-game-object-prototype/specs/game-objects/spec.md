## ADDED Requirements

### Requirement: World Objects
The colony viewport SHALL render four hardcoded game objects at fixed world positions.
Two circles (red, yellow) and two boxes (pink, blue) SHALL be visible and scroll with
the world. Objects SHALL be selectable by clicking within their bounds.

#### Scenario: Objects render in world space
- **WHEN** the game scene draws
- **THEN** all four objects appear at their world positions offset by camera_x

#### Scenario: Click selects a circle
- **WHEN** the player clicks within a circle's radius in screen space
- **THEN** that circle becomes the selected object

#### Scenario: Click selects a box
- **WHEN** the player clicks within a box's bounds in screen space
- **THEN** that box becomes the selected object

#### Scenario: Click on empty space deselects
- **WHEN** the player clicks in the viewport and no object is hit
- **THEN** the selected object is cleared and the config panel closes

### Requirement: Object Data Shape
Each game object SHALL carry: kind ("circle" or "box"), color, world position, dimensions,
and an array of 1–3 sliders each with a left label, right label, and a value in [0, 1].
Boxes SHALL additionally carry one slot descriptor.

#### Scenario: Prototype objects initialise with correct sliders
- **WHEN** game objects are initialised
- **THEN** red circle has slider "Speed ↔ Discipline", yellow has "Strength ↔ Precision",
  pink box has "Input ↔ Output", blue box has "Power ↔ Efficiency"
