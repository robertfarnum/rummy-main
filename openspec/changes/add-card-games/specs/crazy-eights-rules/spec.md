## ADDED Requirements

### Requirement: Crazy Eights rules screen accessible from game config
The system SHALL provide a dedicated rules screen for Crazy Eights, accessible via the `rulesScreenBuilder` in the Crazy Eights `GameConfig`.

#### Scenario: User navigates to Crazy Eights rules
- **WHEN** user taps the info button while Crazy Eights is the selected game
- **THEN** the app SHALL navigate to the Crazy Eights rules screen

### Requirement: Crazy Eights rules screen displays objective
The Crazy Eights rules screen SHALL display a collapsible section explaining the objective: be the first to get rid of all your cards, scoring points from opponents' remaining cards.

#### Scenario: Objective section visible
- **WHEN** user views the Crazy Eights rules screen
- **THEN** the screen SHALL display an expandable section titled "Objective"

### Requirement: Crazy Eights rules screen displays setup
The Crazy Eights rules screen SHALL display a collapsible section explaining the setup: standard 52-card deck, 2–7 players, 5 cards dealt (2–4 players) or 7 cards dealt (5+ players is sometimes used), remaining cards form stock pile with top card face up as starter.

#### Scenario: Setup section visible
- **WHEN** user expands the "Setup" section
- **THEN** the section SHALL explain dealing, stock pile, and starter card

### Requirement: Crazy Eights rules screen displays gameplay
The Crazy Eights rules screen SHALL display a collapsible section explaining gameplay: players play a card matching the top discard by suit or rank. Eights are wild and can be played anytime — the player declares the new suit. If unable to play, draw from stock until a playable card is found.

#### Scenario: Gameplay section visible
- **WHEN** user expands the "Gameplay" section
- **THEN** the section SHALL explain matching rules, wild eights, suit declaration, and drawing

### Requirement: Crazy Eights rules screen displays scoring
The Crazy Eights rules screen SHALL display a collapsible section explaining scoring: when a player goes out, they score points from opponents' remaining cards (8s = 50 pts, face cards = 10 pts, Aces = 1 pt, number cards = face value). First to reach the target score wins.

#### Scenario: Scoring section visible
- **WHEN** user expands the "Scoring" section
- **THEN** the section SHALL explain card point values and the target score for winning

### Requirement: Crazy Eights rules sections are collapsible
Each Crazy Eights rules section SHALL use ExpansionTile widgets that start collapsed.

#### Scenario: Sections start collapsed
- **WHEN** user first opens the Crazy Eights rules screen
- **THEN** all sections SHALL be in collapsed state
