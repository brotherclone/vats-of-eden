## MODIFIED Requirements

### Requirement: Card Tray
The game scene SHALL render a card tray in the lower region of the screen containing
three evenly-spaced placeholder card slots. The tray height SHALL animate between a
collapsed state (140px) and an expanded state (260px) using a 500ms cubic ease-in-out,
growing upward from the bottom edge of the screen (y = 720 − current_height).
Card dimensions SHALL scale proportionally with the current tray height.

#### Scenario: Tray occupies lower region when collapsed
- **WHEN** the tray is fully collapsed
- **THEN** the card tray fills x=0, y=580, w=1280, h=140

#### Scenario: Tray occupies lower region when expanded
- **WHEN** the tray is fully expanded
- **THEN** the card tray fills x=0, y=460, w=1280, h=260

#### Scenario: Three placeholder cards are visible
- **WHEN** the card tray draws
- **THEN** three card rectangles are rendered, evenly spaced horizontally within the tray

#### Scenario: Click inside tray expands it
- **WHEN** the player clicks anywhere within the current tray bounds
- **THEN** the tray animates toward the expanded state over 500ms

#### Scenario: Mouse leaves tray collapses it
- **WHEN** the mouse moves outside the current tray bounds while the tray is expanding or expanded
- **THEN** the tray animates toward the collapsed state over 500ms

#### Scenario: Click outside tray collapses it
- **WHEN** the player clicks outside the current tray bounds
- **THEN** the tray animates toward the collapsed state over 500ms

#### Scenario: Animation is interruptible
- **WHEN** the tray is mid-animation and the trigger reverses (e.g. mouse leaves during expand)
- **THEN** the animation reverses from its current progress without jumping
