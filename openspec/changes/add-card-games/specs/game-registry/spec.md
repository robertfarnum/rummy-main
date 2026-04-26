## ADDED Requirements

### Requirement: Game configuration model
The system SHALL define a `GameConfig` class that represents the configuration for a supported card game, including `id` (String), `name` (String), `minPlayers` (int), `maxPlayers` (int), `defaultTargetScore` (int, nullable), `scoreTypes` (list of `ScoreType`), `winCondition` (WinCondition enum), `hasTargetScore` (bool), and `rulesScreenBuilder` (function returning a Widget).

#### Scenario: GameConfig contains all required fields
- **WHEN** a `GameConfig` instance is created
- **THEN** it SHALL have an `id`, `name`, `minPlayers`, `maxPlayers`, `defaultTargetScore`, `scoreTypes`, `winCondition`, `hasTargetScore`, and `rulesScreenBuilder`

### Requirement: Score type model
The system SHALL define a `ScoreType` class with `id` (String), `label` (String), and `bonusPoints` (int, default 0) to represent a scoring category for a game.

#### Scenario: ScoreType with bonus
- **WHEN** a `ScoreType` is defined with `bonusPoints` greater than 0
- **THEN** the bonus SHALL be automatically added to the entered score when that type is selected

#### Scenario: ScoreType without bonus
- **WHEN** a `ScoreType` is defined with `bonusPoints` of 0
- **THEN** the entered score SHALL be used as-is

### Requirement: Win condition enum
The system SHALL define a `WinCondition` enum with values `highest`, `lowest`, and `winLoss` to control how winners are determined.

#### Scenario: Highest win condition
- **WHEN** a game uses `WinCondition.highest`
- **THEN** the player with the most points SHALL be the winner

#### Scenario: Lowest win condition
- **WHEN** a game uses `WinCondition.lowest`
- **THEN** the player with the fewest points SHALL be the winner

#### Scenario: Win/loss win condition
- **WHEN** a game uses `WinCondition.winLoss`
- **THEN** the system SHALL track games won rather than cumulative points

### Requirement: Static game registry
The system SHALL provide a static list `GameConfig.allGames` containing configurations for all supported card games: Gin Rummy, German Whist, Cribbage, Golf, Slapjack, War, Double Solitaire, and Crazy Eights.

#### Scenario: All games registered
- **WHEN** the app accesses `GameConfig.allGames`
- **THEN** the list SHALL contain exactly 8 game configurations

#### Scenario: Lookup game by ID
- **WHEN** the system looks up a game config by its `id` string
- **THEN** it SHALL return the matching `GameConfig` or default to Gin Rummy if not found

### Requirement: Gin Rummy game configuration
The Gin Rummy entry SHALL have id `'gin-rummy'`, 2 players, default target score 100, score types Knock (0 bonus) and Gin (25 bonus), and `WinCondition.highest`.

#### Scenario: Gin Rummy config values
- **WHEN** the Gin Rummy config is accessed
- **THEN** it SHALL have `minPlayers: 2`, `maxPlayers: 2`, `defaultTargetScore: 100`, two score types (Knock and Gin with 25-point bonus), and `WinCondition.highest`

### Requirement: German Whist game configuration
The German Whist entry SHALL have id `'german-whist'`, 2 players, no target score, score type Tricks Won (0 bonus), and `WinCondition.highest`.

#### Scenario: German Whist config values
- **WHEN** the German Whist config is accessed
- **THEN** it SHALL have `minPlayers: 2`, `maxPlayers: 2`, `hasTargetScore: false`, one score type (Tricks Won), and `WinCondition.highest`

### Requirement: Cribbage game configuration
The Cribbage entry SHALL have id `'cribbage'`, 2–4 players, default target score 121, score type Points (0 bonus), and `WinCondition.highest`.

#### Scenario: Cribbage config values
- **WHEN** the Cribbage config is accessed
- **THEN** it SHALL have `minPlayers: 2`, `maxPlayers: 4`, `defaultTargetScore: 121`, one score type (Points), and `WinCondition.highest`

### Requirement: Golf game configuration
The Golf entry SHALL have id `'golf'`, 2–6 players, no target score, score type Round Score (0 bonus), and `WinCondition.lowest`.

#### Scenario: Golf config values
- **WHEN** the Golf config is accessed
- **THEN** it SHALL have `minPlayers: 2`, `maxPlayers: 6`, `hasTargetScore: false`, one score type (Round Score), and `WinCondition.lowest`

### Requirement: Slapjack game configuration
The Slapjack entry SHALL have id `'slapjack'`, 2–8 players, no target score, score type Game Won (0 bonus), and `WinCondition.winLoss`.

#### Scenario: Slapjack config values
- **WHEN** the Slapjack config is accessed
- **THEN** it SHALL have `minPlayers: 2`, `maxPlayers: 8`, `hasTargetScore: false`, one score type (Game Won), and `WinCondition.winLoss`

### Requirement: War game configuration
The War entry SHALL have id `'war'`, 2–4 players, no target score, score type Game Won (0 bonus), and `WinCondition.winLoss`.

#### Scenario: War config values
- **WHEN** the War config is accessed
- **THEN** it SHALL have `minPlayers: 2`, `maxPlayers: 4`, `hasTargetScore: false`, one score type (Game Won), and `WinCondition.winLoss`

### Requirement: Double Solitaire game configuration
The Double Solitaire entry SHALL have id `'double-solitaire'`, 2 players, no target score, score type Cards Played (0 bonus), and `WinCondition.highest`.

#### Scenario: Double Solitaire config values
- **WHEN** the Double Solitaire config is accessed
- **THEN** it SHALL have `minPlayers: 2`, `maxPlayers: 2`, `hasTargetScore: false`, one score type (Cards Played), and `WinCondition.highest`

### Requirement: Crazy Eights game configuration
The Crazy Eights entry SHALL have id `'crazy-eights'`, 2–7 players, default target score 100, score type Points (0 bonus), and `WinCondition.highest`.

#### Scenario: Crazy Eights config values
- **WHEN** the Crazy Eights config is accessed
- **THEN** it SHALL have `minPlayers: 2`, `maxPlayers: 7`, `defaultTargetScore: 100`, one score type (Points), and `WinCondition.highest`
