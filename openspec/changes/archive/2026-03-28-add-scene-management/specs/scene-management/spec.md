## ADDED Requirements

### Requirement: Scene Manager
The system SHALL provide a scene manager that holds one active scene at a time and delegates LÖVE callbacks (`update`, `draw`, `keypressed`) to it.

#### Scenario: Switch to a registered scene
- **WHEN** `scene_manager.switch("setup")` is called
- **THEN** the setup scene becomes active and receives all subsequent callbacks

#### Scenario: Unregistered scene switch
- **WHEN** `scene_manager.switch("unknown")` is called
- **THEN** an error is raised indicating the scene is not registered

---

### Requirement: Load Scene
The system SHALL display a load screen as the initial scene. The screen SHALL show a "Start" button only after all assets have finished loading. Clicking the button SHALL transition to the setup scene.

#### Scenario: Button hidden during loading
- **WHEN** the load scene is active and assets are still loading
- **THEN** no button is rendered

#### Scenario: Button appears when ready
- **WHEN** all assets have finished loading
- **THEN** the "Start" button is rendered on screen

#### Scenario: Transition to setup
- **WHEN** the player clicks the "Start" button
- **THEN** the scene manager switches to the setup scene

---

### Requirement: Setup Scene
The system SHALL display a setup screen with a "Play" button. Clicking the button SHALL transition to the game scene.

#### Scenario: Play button visible
- **WHEN** the setup scene is active
- **THEN** a "Play" button is rendered on screen

#### Scenario: Transition to game
- **WHEN** the player clicks "Play"
- **THEN** the scene manager switches to the game scene

---

### Requirement: Game Scene
The system SHALL display the game runtime with no UI buttons visible by default. Pressing ESC SHALL toggle an overlay containing an "Exit" button. Clicking "Exit" SHALL return to the setup scene.

#### Scenario: No UI on entry
- **WHEN** the game scene becomes active
- **THEN** no buttons are rendered

#### Scenario: ESC shows overlay
- **WHEN** the player presses ESC while the overlay is hidden
- **THEN** an overlay with an "Exit" button is rendered

#### Scenario: ESC hides overlay
- **WHEN** the player presses ESC while the overlay is visible
- **THEN** the overlay is hidden

#### Scenario: Exit returns to setup
- **WHEN** the player clicks "Exit" on the overlay
- **THEN** the scene manager switches to the setup scene
