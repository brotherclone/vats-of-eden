## ADDED Requirements

### Requirement: Card Tray
The game scene SHALL render a card tray in the lower region of the screen (1280×140px at y=580) containing three evenly-spaced placeholder card slots.

#### Scenario: Tray occupies lower region
- **WHEN** the game scene draws
- **THEN** the card tray fills x=0, y=580, w=1280, h=140

#### Scenario: Three placeholder cards are visible
- **WHEN** the card tray draws
- **THEN** three card rectangles are rendered, evenly spaced horizontally within the tray
