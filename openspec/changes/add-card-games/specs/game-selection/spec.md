## ADDED Requirements

### Requirement: Game selection dropdown on home screen
The home screen SHALL display a game selection dropdown within the Game Setup card, above the player name fields, allowing users to choose which card game to play.

#### Scenario: User sees game selector
- **WHEN** user views the home screen
- **THEN** the Game Setup card SHALL display a dropdown listing all supported games from `GameConfig.allGames`

#### Scenario: User selects a game
- **WHEN** user selects a game from the dropdown
- **THEN** the selected game's configuration SHALL drive player count validation, default target score, and available score types

### Requirement: Player count validation per game
The home screen SHALL validate the number of added players against the selected game's `minPlayers` and `maxPlayers` from its `GameConfig`.

#### Scenario: Too few players
- **WHEN** user attempts to start a game with fewer players than the selected game's `minPlayers`
- **THEN** the system SHALL display a message indicating the minimum number of players required

#### Scenario: Too many players
- **WHEN** user attempts to add a player beyond the selected game's `maxPlayers`
- **THEN** the system SHALL display a message indicating the maximum number of players allowed

### Requirement: Default target score from game config
The home screen SHALL pre-populate the target score field with the selected game's `defaultTargetScore` when a game is selected.

#### Scenario: Game with target score
- **WHEN** user selects a game that has `hasTargetScore: true`
- **THEN** the target score field SHALL be visible and pre-populated with the game's `defaultTargetScore`

#### Scenario: Game without target score
- **WHEN** user selects a game that has `hasTargetScore: false`
- **THEN** the target score field SHALL be hidden

### Requirement: Game type passed to new game
The home screen SHALL pass the selected `GameConfig.id` as the `gameType` when creating a new `Game` instance.

#### Scenario: Starting a new game
- **WHEN** user starts a new game with a selected game type
- **THEN** the `Game` instance SHALL be created with the `gameType` set to the selected game's `id`

### Requirement: Info button navigates to selected game's rules
The home screen info button SHALL navigate to the rules screen for the currently selected game, using the `rulesScreenBuilder` from the selected `GameConfig`.

#### Scenario: User taps info button with game selected
- **WHEN** user taps the info icon button on the home screen AppBar
- **THEN** the app SHALL navigate to the rules screen for the currently selected game

### Requirement: App title reflects multi-game support
The app title and home screen AppBar SHALL display "Card Game Scorekeeper" instead of "Gin Rummy Scorekeeper".

#### Scenario: App title displayed
- **WHEN** user views the home screen
- **THEN** the AppBar title SHALL read "Card Game Scorekeeper"

### Requirement: Score entry uses game-specific score types
The score entry screen SHALL display score type options from the current game's `GameConfig.scoreTypes` instead of hardcoded Knock/Gin options.

#### Scenario: Scoring game score entry
- **WHEN** user enters scores for a game with `WinCondition.highest` or `WinCondition.lowest`
- **THEN** the score entry screen SHALL display radio buttons for each of the game's configured score types and a numeric score input

#### Scenario: Win/loss game score entry
- **WHEN** user enters scores for a game with `WinCondition.winLoss`
- **THEN** the score entry screen SHALL display a "Select Winner" interface instead of point entry, awarding 1 point to the selected winner

#### Scenario: Bonus points applied automatically
- **WHEN** user selects a score type with `bonusPoints` greater than 0
- **THEN** the bonus SHALL be added to the entered score automatically

### Requirement: Game model stores game type
The `Game` model SHALL include a `gameType` (String) field that identifies which card game is being played, defaulting to `'gin-rummy'` for backward compatibility.

#### Scenario: New game with game type
- **WHEN** a new `Game` is created with a specified `gameType`
- **THEN** the game SHALL store the `gameType` and provide access to the corresponding `GameConfig`

#### Scenario: Saved game without game type
- **WHEN** a saved game is loaded that does not include a `gameType` field
- **THEN** the `gameType` SHALL default to `'gin-rummy'`

### Requirement: Winner determination uses win condition
The `Game.getWinners()` method SHALL determine winners based on the game's `WinCondition` enum value.

#### Scenario: Highest score wins
- **WHEN** a game with `WinCondition.highest` finishes
- **THEN** `getWinners()` SHALL return the player(s) with the highest score

#### Scenario: Lowest score wins
- **WHEN** a game with `WinCondition.lowest` finishes
- **THEN** `getWinners()` SHALL return the player(s) with the lowest score

#### Scenario: Win/loss tracking
- **WHEN** a game with `WinCondition.winLoss` finishes
- **THEN** `getWinners()` SHALL return the player(s) with the most games won
