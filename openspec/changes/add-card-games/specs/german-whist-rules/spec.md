## ADDED Requirements

### Requirement: German Whist rules screen accessible from game config
The system SHALL provide a dedicated rules screen for German Whist, accessible via the `rulesScreenBuilder` in the German Whist `GameConfig`.

#### Scenario: User navigates to German Whist rules
- **WHEN** user taps the info button while German Whist is the selected game
- **THEN** the app SHALL navigate to the German Whist rules screen

### Requirement: German Whist rules screen displays objective
The German Whist rules screen SHALL display a collapsible section explaining the objective: win more tricks than your opponent in the second phase of play.

#### Scenario: Objective section visible
- **WHEN** user views the German Whist rules screen
- **THEN** the screen SHALL display an expandable section titled "Objective"

### Requirement: German Whist rules screen displays setup
The German Whist rules screen SHALL display a collapsible section explaining the setup: standard 52-card deck, 2 players, 13 cards each, remaining cards form stock pile with top card face up.

#### Scenario: Setup section visible
- **WHEN** user expands the "Setup" section
- **THEN** the section SHALL explain the deck, card count per player, and stock pile formation

### Requirement: German Whist rules screen displays gameplay
The German Whist rules screen SHALL display a collapsible section explaining the two-phase gameplay: Phase 1 (stock phase) where players play tricks to win stock cards, and Phase 2 (play phase) where remaining 13 tricks are played for score.

#### Scenario: Gameplay section visible
- **WHEN** user expands the "Gameplay" section
- **THEN** the section SHALL explain both phases, trick-taking rules, and following suit

### Requirement: German Whist rules screen displays scoring
The German Whist rules screen SHALL display a collapsible section explaining scoring: tricks won in Phase 2 are counted, and the player with more tricks wins.

#### Scenario: Scoring section visible
- **WHEN** user expands the "Scoring" section
- **THEN** the section SHALL explain that only Phase 2 tricks count and the player with more tricks wins

### Requirement: German Whist rules sections are collapsible
Each German Whist rules section SHALL use ExpansionTile widgets that start collapsed.

#### Scenario: Sections start collapsed
- **WHEN** user first opens the German Whist rules screen
- **THEN** all sections SHALL be in collapsed state
