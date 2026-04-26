## ADDED Requirements

### Requirement: Golf rules screen accessible from game config
The system SHALL provide a dedicated rules screen for Golf (card game), accessible via the `rulesScreenBuilder` in the Golf `GameConfig`.

#### Scenario: User navigates to Golf rules
- **WHEN** user taps the info button while Golf is the selected game
- **THEN** the app SHALL navigate to the Golf rules screen

### Requirement: Golf rules screen displays objective
The Golf rules screen SHALL display a collapsible section explaining the objective: achieve the lowest total score across 9 rounds.

#### Scenario: Objective section visible
- **WHEN** user views the Golf rules screen
- **THEN** the screen SHALL display an expandable section titled "Objective"

### Requirement: Golf rules screen displays setup
The Golf rules screen SHALL display a collapsible section explaining the setup: standard 52-card deck, 2–6 players, 6 cards dealt face down in a 2x3 grid, two cards flipped face up.

#### Scenario: Setup section visible
- **WHEN** user expands the "Setup" section
- **THEN** the section SHALL explain the card layout, stock pile, and discard pile formation

### Requirement: Golf rules screen displays card values
The Golf rules screen SHALL display a collapsible section explaining card values: Ace = 1, 2–10 = face value, Jack/Queen = 10, King = 0, and paired column scoring (matching cards in a column = 0).

#### Scenario: Card values section visible
- **WHEN** user expands the "Card Values" section
- **THEN** the section SHALL explain each card's point value and the column-matching rule

### Requirement: Golf rules screen displays gameplay
The Golf rules screen SHALL display a collapsible section explaining gameplay: drawing from stock or discard, replacing a face-down or face-up card, or discarding. The round ends when all of a player's cards are face up.

#### Scenario: Gameplay section visible
- **WHEN** user expands the "Gameplay" section
- **THEN** the section SHALL explain turn actions, card replacement, and round-ending conditions

### Requirement: Golf rules screen displays scoring
The Golf rules screen SHALL display a collapsible section explaining scoring: sum of all 6 cards at round end, lowest cumulative score after 9 rounds wins.

#### Scenario: Scoring section visible
- **WHEN** user expands the "Scoring" section
- **THEN** the section SHALL explain per-round scoring and cumulative scoring across 9 rounds

### Requirement: Golf rules sections are collapsible
Each Golf rules section SHALL use ExpansionTile widgets that start collapsed.

#### Scenario: Sections start collapsed
- **WHEN** user first opens the Golf rules screen
- **THEN** all sections SHALL be in collapsed state
