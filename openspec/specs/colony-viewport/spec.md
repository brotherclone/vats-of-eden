# colony-viewport Specification

## Purpose
TBD - created by archiving change add-colony-viewport-and-card-tray. Update Purpose after archive.
## Requirements
### Requirement: Colony Viewport
The game scene SHALL render a horizontally-scrollable colony viewport occupying the
screen area above the card tray. The viewport height SHALL be dynamic: `720 − tray_current_height`,
so that as the tray animates the viewport shrinks or grows in real time without overlap.
The world width remains 3× the viewport width (3840px) with camera offset clamped to [0, 2560].

#### Scenario: Viewport fills space above collapsed tray
- **WHEN** the card tray is fully collapsed (h=140)
- **THEN** the colony viewport height is 580px (y=0 to y=580)

#### Scenario: Viewport fills space above expanded tray
- **WHEN** the card tray is fully expanded (h=260)
- **THEN** the colony viewport height is 460px (y=0 to y=460)

#### Scenario: Viewport updates continuously during animation
- **WHEN** the card tray is mid-animation
- **THEN** the colony viewport scissor rect matches 720 − tray_current_height each frame

#### Scenario: Camera does not scroll past left edge
- **WHEN** the camera offset would go below 0
- **THEN** it is clamped to 0

#### Scenario: Camera does not scroll past right edge
- **WHEN** the camera offset would exceed 2560
- **THEN** it is clamped to 2560

#### Scenario: Edge scroll respects current viewport height
- **WHEN** the mouse is within 60px of the left or right edge of the viewport
- **THEN** the camera scrolls regardless of the tray's current height

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

