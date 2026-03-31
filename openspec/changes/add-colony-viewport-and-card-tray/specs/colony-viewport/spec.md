## ADDED Requirements

### Requirement: Colony Viewport
The game scene SHALL render a horizontally-scrollable colony viewport occupying the upper region of the screen (1280×580px at y=0). The colony world SHALL be 3× the viewport width (3840px), with a camera offset clamped to the range [0, 2560].

#### Scenario: Viewport renders at correct region
- **WHEN** the game scene draws
- **THEN** the colony viewport fills x=0, y=0, w=1280, h=580

#### Scenario: Camera does not scroll past left edge
- **WHEN** the camera offset would go below 0
- **THEN** it is clamped to 0

#### Scenario: Camera does not scroll past right edge
- **WHEN** the camera offset would exceed 2560 (world_width - viewport_width)
- **THEN** it is clamped to 2560

### Requirement: Edge Scroll
The colony viewport SHALL scroll when the mouse cursor is within 60px of the left or right edge of the viewport.

#### Scenario: Mouse near left edge scrolls left
- **WHEN** mouse x is between 0 and 59 (inclusive) during update
- **THEN** the camera offset decreases at scroll speed (pixels/sec)

#### Scenario: Mouse near right edge scrolls right
- **WHEN** mouse x is between 1220 and 1279 (inclusive) during update
- **THEN** the camera offset increases at scroll speed (pixels/sec)

#### Scenario: Mouse in centre does not scroll
- **WHEN** mouse x is between 60 and 1219
- **THEN** camera offset is unchanged by mouse position

### Requirement: Arrow Key Scroll
The colony viewport SHALL scroll left or right when the left or right arrow key is held.

#### Scenario: Left arrow scrolls left
- **WHEN** the left arrow key is held and update is called
- **THEN** the camera offset decreases at scroll speed (pixels/sec)

#### Scenario: Right arrow scrolls right
- **WHEN** the right arrow key is held and update is called
- **THEN** the camera offset increases at scroll speed (pixels/sec)
