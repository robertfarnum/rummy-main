## MODIFIED Requirements

### Requirement: Rules screen accessible from home
The system SHALL provide a dedicated Gin Rummy rules screen accessible via the info button on the home screen AppBar when Gin Rummy is the selected game, and via the `rulesScreenBuilder` in the Gin Rummy `GameConfig`.

#### Scenario: User taps info button with Gin Rummy selected
- **WHEN** user taps the info icon button on the home screen AppBar while Gin Rummy is the selected game
- **THEN** the app SHALL navigate to the Gin Rummy rules screen

#### Scenario: User taps info button with different game selected
- **WHEN** user taps the info icon button while a different game is selected
- **THEN** the app SHALL navigate to that game's rules screen, not the Gin Rummy rules screen

#### Scenario: User returns from rules screen
- **WHEN** user taps the back button on the rules screen
- **THEN** the app SHALL navigate back to the home screen
