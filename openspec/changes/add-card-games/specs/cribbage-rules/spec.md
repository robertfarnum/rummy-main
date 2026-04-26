## ADDED Requirements

### Requirement: Cribbage rules screen accessible from game config
The system SHALL provide a dedicated rules screen for Cribbage, accessible via the `rulesScreenBuilder` in the Cribbage `GameConfig`.

#### Scenario: User navigates to Cribbage rules
- **WHEN** user taps the info button while Cribbage is the selected game
- **THEN** the app SHALL navigate to the Cribbage rules screen

### Requirement: Cribbage rules screen displays objective
The Cribbage rules screen SHALL display a collapsible section explaining the objective: be the first player to reach 121 points through pegging and hand scoring.

#### Scenario: Objective section visible
- **WHEN** user views the Cribbage rules screen
- **THEN** the screen SHALL display an expandable section titled "Objective"

### Requirement: Cribbage rules screen displays setup
The Cribbage rules screen SHALL display a collapsible section explaining the setup: standard 52-card deck, 2–4 players, 6 cards dealt (2-player) or 5 cards dealt (3–4 players), creating a 4-card hand and discarding to the crib.

#### Scenario: Setup section visible
- **WHEN** user expands the "Setup" section
- **THEN** the section SHALL explain dealing, the crib, and the starter card (cut card)

### Requirement: Cribbage rules screen displays gameplay
The Cribbage rules screen SHALL display a collapsible section explaining gameplay: the pegging phase (playing cards to count toward 31) and the hand-scoring phase.

#### Scenario: Gameplay section visible
- **WHEN** user expands the "Gameplay" section
- **THEN** the section SHALL explain pegging (playing cards, counting to 31, scoring pairs/runs/15s) and hand scoring

### Requirement: Cribbage rules screen displays scoring
The Cribbage rules screen SHALL display a collapsible section explaining scoring combinations: 15s (2 pts), pairs (2 pts), runs (1 pt per card), flush (4–5 pts), nobs (1 pt), and his heels (2 pts).

#### Scenario: Scoring section visible
- **WHEN** user expands the "Scoring" section
- **THEN** the section SHALL explain all scoring combinations with point values

### Requirement: Cribbage rules screen displays winning
The Cribbage rules screen SHALL display a collapsible section explaining how to win: first to 121 points, with skunking (opponent under 91).

#### Scenario: Winning section visible
- **WHEN** user expands the "Winning" section
- **THEN** the section SHALL explain the 121-point target and skunking

### Requirement: Cribbage rules sections are collapsible
Each Cribbage rules section SHALL use ExpansionTile widgets that start collapsed.

#### Scenario: Sections start collapsed
- **WHEN** user first opens the Cribbage rules screen
- **THEN** all sections SHALL be in collapsed state
