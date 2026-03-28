# button-ui Specification

## Purpose
TBD - created by archiving change add-scene-management. Update Purpose after archive.
## Requirements
### Requirement: Button Component
The system SHALL provide a reusable Button component that can be positioned, labelled, drawn, and clicked. It SHALL be usable from any scene without scene-specific logic.

#### Scenario: Create a button
- **WHEN** `Button.new(x, y, w, h, label)` is called
- **THEN** a button instance is returned with the given position, size, and label

#### Scenario: Draw a button
- **WHEN** `button:draw()` is called
- **THEN** the button rectangle and label are rendered at its configured position

#### Scenario: Detect a click
- **WHEN** `button:clicked(mx, my)` is called with coordinates inside the button bounds
- **THEN** it returns `true`

#### Scenario: Miss outside bounds
- **WHEN** `button:clicked(mx, my)` is called with coordinates outside the button bounds
- **THEN** it returns `false`

