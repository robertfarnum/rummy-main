## ADDED Requirements

### Requirement: Slapjack rules screen accessible from game config
The system SHALL provide a dedicated rules screen for Slapjack, accessible via the `rulesScreenBuilder` in the Slapjack `GameConfig`.

#### Scenario: User navigates to Slapjack rules
- **WHEN** user taps the info button while Slapjack is the selected game
- **THEN** the app SHALL navigate to the Slapjack rules screen

### Requirement: Slapjack rules screen displays objective
The Slapjack rules screen SHALL display a collapsible section explaining the objective: win all the cards by being the first to slap jacks.

#### Scenario: Objective section visible
- **WHEN** user views the Slapjack rules screen
- **THEN** the screen SHALL display an expandable section titled "Objective"

### Requirement: Slapjack rules screen displays setup
The Slapjack rules screen SHALL display a collapsible section explaining the setup: standard 52-card deck, 2–8 players, all cards dealt face down as evenly as possible.

#### Scenario: Setup section visible
- **WHEN** user expands the "Setup" section
- **THEN** the section SHALL explain dealing and player card piles

### Requirement: Slapjack rules screen displays gameplay
The Slapjack rules screen SHALL display a collapsible section explaining gameplay: players take turns flipping their top card to a central pile, and when a Jack appears anyone can slap it to win the pile.

#### Scenario: Gameplay section visible
- **WHEN** user expands the "Gameplay" section
- **THEN** the section SHALL explain turn order, card flipping, slapping jacks, and penalties for false slaps

### Requirement: Slapjack rules screen displays winning
The Slapjack rules screen SHALL display a collapsible section explaining how to win: collect all the cards. Players who run out of cards are eliminated unless they slap a jack.

#### Scenario: Winning section visible
- **WHEN** user expands the "Winning" section
- **THEN** the section SHALL explain elimination and winning conditions

### Requirement: Slapjack rules screen displays app scoring note
The Slapjack rules screen SHALL display a collapsible section explaining that this app tracks wins per session since Slapjack has no point system.

#### Scenario: App scoring note visible
- **WHEN** user expands the "In This App" section
- **THEN** the section SHALL explain that the app tracks games won rather than points

### Requirement: Slapjack rules sections are collapsible
Each Slapjack rules section SHALL use ExpansionTile widgets that start collapsed.

#### Scenario: Sections start collapsed
- **WHEN** user first opens the Slapjack rules screen
- **THEN** all sections SHALL be in collapsed state
