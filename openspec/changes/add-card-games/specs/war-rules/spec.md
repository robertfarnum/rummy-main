## ADDED Requirements

### Requirement: War rules screen accessible from game config
The system SHALL provide a dedicated rules screen for War, accessible via the `rulesScreenBuilder` in the War `GameConfig`.

#### Scenario: User navigates to War rules
- **WHEN** user taps the info button while War is the selected game
- **THEN** the app SHALL navigate to the War rules screen

### Requirement: War rules screen displays objective
The War rules screen SHALL display a collapsible section explaining the objective: win all the cards by playing higher cards than your opponent.

#### Scenario: Objective section visible
- **WHEN** user views the War rules screen
- **THEN** the screen SHALL display an expandable section titled "Objective"

### Requirement: War rules screen displays setup
The War rules screen SHALL display a collapsible section explaining the setup: standard 52-card deck, 2–4 players, all cards dealt face down as evenly as possible.

#### Scenario: Setup section visible
- **WHEN** user expands the "Setup" section
- **THEN** the section SHALL explain dealing and card ranking (Ace high)

### Requirement: War rules screen displays gameplay
The War rules screen SHALL display a collapsible section explaining gameplay: all players flip their top card simultaneously, highest card wins all flipped cards. Tied cards trigger a "war" — each tied player places cards face down then flips another.

#### Scenario: Gameplay section visible
- **WHEN** user expands the "Gameplay" section
- **THEN** the section SHALL explain card flipping, comparing, winning tricks, and the war mechanic for ties

### Requirement: War rules screen displays winning
The War rules screen SHALL display a collapsible section explaining how to win: collect all the cards, or have the most cards when players agree to stop.

#### Scenario: Winning section visible
- **WHEN** user expands the "Winning" section
- **THEN** the section SHALL explain winning conditions

### Requirement: War rules screen displays app scoring note
The War rules screen SHALL display a collapsible section explaining that this app tracks wins per session since War has no point system.

#### Scenario: App scoring note visible
- **WHEN** user expands the "In This App" section
- **THEN** the section SHALL explain that the app tracks games won rather than points

### Requirement: War rules sections are collapsible
Each War rules section SHALL use ExpansionTile widgets that start collapsed.

#### Scenario: Sections start collapsed
- **WHEN** user first opens the War rules screen
- **THEN** all sections SHALL be in collapsed state
