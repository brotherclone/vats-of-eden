## ADDED Requirements

### Requirement: Tick Accumulation
The tick system SHALL accumulate delta time passed to `Tick.update(dt)` and fire all registered listeners once per configured interval, using a `while` loop so that multiple ticks may fire in a single update if frames were slow.

#### Scenario: Single tick fires after one interval elapses
- **WHEN** `Tick.update` is called repeatedly with dt values that sum to >= the configured interval
- **THEN** all registered listeners are called exactly once with the current tick count

#### Scenario: Multiple ticks fire during a slow frame
- **WHEN** a single `Tick.update` call receives a dt greater than the configured interval
- **THEN** listeners are called once per full interval elapsed within that dt, each time with the incremented tick count

#### Scenario: No tick fires before interval elapses
- **WHEN** cumulative dt is less than the configured interval
- **THEN** no listeners are called

### Requirement: Listener Registration
The tick system SHALL allow any module to register a callback function via `Tick.subscribe(fn)`. The function SHALL be called on every subsequent tick until unsubscribed. `subscribe` SHALL return the function reference as a handle for later removal.

#### Scenario: Registered listener receives ticks
- **WHEN** a function is passed to `Tick.subscribe`
- **THEN** that function is called on every tick that fires after registration

#### Scenario: Subscribe returns the function handle
- **WHEN** `Tick.subscribe(fn)` is called
- **THEN** the return value is the same function reference `fn`

### Requirement: Listener Deregistration
The tick system SHALL allow a previously registered listener to be removed via `Tick.unsubscribe(fn)`. After removal, the function SHALL NOT be called on subsequent ticks.

#### Scenario: Unsubscribed listener no longer fires
- **WHEN** a listener is removed via `Tick.unsubscribe`
- **THEN** it is not called on any tick that fires after the removal

#### Scenario: Unsubscribing a non-registered function is a no-op
- **WHEN** `Tick.unsubscribe` is called with a function that was never subscribed
- **THEN** no error is raised and existing listeners are unaffected

### Requirement: Tick Count
Each tick event SHALL pass a monotonically increasing integer tick count (starting at 1) to every listener. The count SHALL not reset across scene transitions.

#### Scenario: Tick count increments each tick
- **WHEN** the tick interval elapses multiple times
- **THEN** listeners receive 1, 2, 3, … on successive ticks

#### Scenario: Tick count persists across scene changes
- **WHEN** the active scene changes between two ticks
- **THEN** the tick count continues from where it left off

### Requirement: Configurable Interval
The tick system SHALL default to a 1.0-second interval and SHALL expose the interval as a readable field (`Tick.interval`) so other systems can reference it.

#### Scenario: Default interval is one second
- **WHEN** the tick module is loaded without any configuration
- **THEN** `Tick.interval` equals 1.0

#### Scenario: Interval field is readable
- **WHEN** any module reads `Tick.interval`
- **THEN** it returns the current tick interval in seconds

### Requirement: Integration with Love2D Update Loop
`Tick.update(dt)` SHALL be called from `love.update` in `main.lua`, before `scenes.update(dt)`, so that tick-driven state changes are applied before the active scene updates its own logic.

#### Scenario: Tick fires before scene update
- **WHEN** `love.update(dt)` runs
- **THEN** `Tick.update(dt)` is invoked before `SceneManager.update(dt)`
