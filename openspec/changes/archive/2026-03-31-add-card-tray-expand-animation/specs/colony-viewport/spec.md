## MODIFIED Requirements

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
