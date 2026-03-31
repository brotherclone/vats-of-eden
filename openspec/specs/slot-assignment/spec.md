# slot-assignment Specification

## Purpose
TBD - created by archiving change add-game-object-prototype. Update Purpose after archive.
## Requirements
### Requirement: Box Slot
Each box object SHALL display one slot rendered as a small circle on its top-right corner
in world space. The slot SHALL visually indicate whether it is empty or occupied by
showing the assigned circle's colour or a neutral placeholder.

#### Scenario: Empty slot renders as placeholder
- **WHEN** a box has no assigned circle
- **THEN** its slot renders as a grey outlined circle

#### Scenario: Occupied slot renders assigned circle colour
- **WHEN** a box has an assigned circle
- **THEN** its slot renders filled with that circle's colour

### Requirement: Drag to Assign
The player SHALL be able to drag a circle from the world and drop it onto a box's slot
to assign it. Only one circle may occupy a slot at a time. Assigning a new circle to an
occupied slot SHALL displace the previous occupant (slot becomes unassigned for it).

#### Scenario: Drag begins on circle
- **WHEN** the player presses on a circle in the viewport
- **THEN** a drag ghost of that circle follows the mouse cursor

#### Scenario: Drop on slot assigns circle
- **WHEN** the player releases over a box slot hit zone (16px radius)
- **THEN** the circle is assigned to that slot and the ghost is cleared

#### Scenario: Drop outside any slot cancels drag
- **WHEN** the player releases outside all slot hit zones
- **THEN** the drag is cancelled and the circle returns to its world position

#### Scenario: Reassigning displaces previous occupant
- **WHEN** the player drops a circle onto an already-occupied slot
- **THEN** the slot's previous circle is unassigned and the new circle takes its place

#### Scenario: Scroll suppressed while dragging
- **WHEN** a drag is active
- **THEN** the colony viewport does not edge-scroll

