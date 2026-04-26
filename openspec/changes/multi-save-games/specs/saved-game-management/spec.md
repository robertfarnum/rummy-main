## ADDED Requirements

### Requirement: Multiple games can be saved simultaneously
The system SHALL support storing up to 10 in-progress games at the same time using a `saved_games` StringList in SharedPreferences.

#### Scenario: Saving a new game
- **WHEN** the user starts a new game
- **THEN** the system SHALL append the game's JSON to the `saved_games` list without removing existing entries

#### Scenario: Save slot cap reached
- **WHEN** the `saved_games` list contains 10 games
- **THEN** the system SHALL disable the "Start Game" button and display a message indicating the save limit has been reached

### Requirement: Saved games are listed on the home screen
The system SHALL display all saved in-progress games on the home screen, each showing the game type name, player names, current round, and target score (if applicable).

#### Scenario: Multiple saved games exist
- **WHEN** the user opens the home screen with multiple saved games
- **THEN** the system SHALL display a card for each saved game showing the game type name, player names, round number, and target score (when the game type has a target score)

#### Scenario: No saved games exist
- **WHEN** the user opens the home screen with no saved games
- **THEN** the system SHALL show only the "New Game" setup form with no saved-game section

### Requirement: User can continue any saved game
The system SHALL allow the user to continue any saved game from the home screen by tapping a "Continue" button on that game's card.

#### Scenario: Continuing a saved game
- **WHEN** the user taps "Continue" on a saved game card
- **THEN** the system SHALL navigate to the game screen loaded with that game's data

### Requirement: User can delete a saved game
The system SHALL allow the user to delete any saved game from the home screen via a delete icon on each game card.

#### Scenario: Deleting a saved game with confirmation
- **WHEN** the user taps the delete icon on a saved game card
- **THEN** the system SHALL show a confirmation dialog asking "Delete this [Game Name] game?"

#### Scenario: User confirms deletion
- **WHEN** the user confirms the delete dialog
- **THEN** the system SHALL remove the game from the `saved_games` list and refresh the home screen

#### Scenario: User cancels deletion
- **WHEN** the user cancels the delete dialog
- **THEN** the system SHALL leave the saved game unchanged

### Requirement: Existing single-game save is migrated
The system SHALL migrate an existing `current_game` entry into the new `saved_games` list on first load after upgrade.

#### Scenario: Migration from current_game
- **WHEN** the system loads saved games and `saved_games` is empty but `current_game` exists
- **THEN** the system SHALL move the `current_game` value into `saved_games[0]` and delete the `current_game` key

#### Scenario: No migration needed
- **WHEN** the system loads saved games and `saved_games` already contains entries
- **THEN** the system SHALL NOT read or modify the `current_game` key

### Requirement: Game updates are persisted in place
The system SHALL update the game's entry in the `saved_games` list after each round or state change, rather than appending a new entry.

#### Scenario: Saving after a round
- **WHEN** a round is completed in an active game
- **THEN** the system SHALL overwrite that game's existing entry in the `saved_games` list at its current index

### Requirement: Finished games remain in saved list
When a game finishes, it SHALL remain in the `saved_games` list (in addition to being appended to `game_history`) until the user explicitly deletes it.

#### Scenario: Game finishes
- **WHEN** a game reaches its win condition and is marked finished
- **THEN** the system SHALL keep the game in the `saved_games` list and also save it to `game_history`
