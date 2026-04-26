## ADDED Requirements

### Requirement: Double Solitaire rules screen accessible from game config
The system SHALL provide a dedicated rules screen for Double Solitaire, accessible via the `rulesScreenBuilder` in the Double Solitaire `GameConfig`.

#### Scenario: User navigates to Double Solitaire rules
- **WHEN** user taps the info button while Double Solitaire is the selected game
- **THEN** the app SHALL navigate to the Double Solitaire rules screen

### Requirement: Double Solitaire rules screen displays objective
The Double Solitaire rules screen SHALL display a collapsible section explaining the objective: play more cards to the shared foundation piles than your opponent.

#### Scenario: Objective section visible
- **WHEN** user views the Double Solitaire rules screen
- **THEN** the screen SHALL display an expandable section titled "Objective"

### Requirement: Double Solitaire rules screen displays setup
The Double Solitaire rules screen SHALL display a collapsible section explaining the setup: two standard 52-card decks (one per player, different backs recommended), each player sets up a standard Klondike solitaire layout (7 tableau columns, remaining cards as stock).

#### Scenario: Setup section visible
- **WHEN** user expands the "Setup" section
- **THEN** the section SHALL explain the two-deck setup, tableau layout, and shared foundation area

### Requirement: Double Solitaire rules screen displays gameplay
The Double Solitaire rules screen SHALL display a collapsible section explaining gameplay: players play simultaneously on their own tableaus but share foundation piles (Aces through Kings by suit). Players draw from their own stock piles.

#### Scenario: Gameplay section visible
- **WHEN** user expands the "Gameplay" section
- **THEN** the section SHALL explain simultaneous play, tableau rules, shared foundations, and stock pile usage

### Requirement: Double Solitaire rules screen displays scoring
The Double Solitaire rules screen SHALL display a collapsible section explaining scoring: count the number of cards each player played to the foundation piles. The player with more cards on foundations wins.

#### Scenario: Scoring section visible
- **WHEN** user expands the "Scoring" section
- **THEN** the section SHALL explain foundation card counting and that higher count wins

### Requirement: Double Solitaire rules sections are collapsible
Each Double Solitaire rules section SHALL use ExpansionTile widgets that start collapsed.

#### Scenario: Sections start collapsed
- **WHEN** user first opens the Double Solitaire rules screen
- **THEN** all sections SHALL be in collapsed state
