## ADDED Requirements

### Requirement: Rules screen accessible from home
The system SHALL provide a dedicated rules screen accessible via the info button on the home screen AppBar.

#### Scenario: User taps info button
- **WHEN** user taps the info icon button on the home screen AppBar
- **THEN** the app SHALL navigate to the Gin Rummy rules screen

#### Scenario: User returns from rules screen
- **WHEN** user taps the back button on the rules screen
- **THEN** the app SHALL navigate back to the home screen

### Requirement: Rules screen displays game objective
The rules screen SHALL display a section explaining the objective of Gin Rummy: to form melds (sets and runs) and reduce deadwood to win rounds and reach the target score.

#### Scenario: Objective section visible
- **WHEN** user views the rules screen
- **THEN** the screen SHALL display an expandable section titled "Objective" explaining the goal of Gin Rummy

### Requirement: Rules screen displays card setup
The rules screen SHALL display a section explaining the card setup: standard 52-card deck, card values (face cards = 10, Aces = 1, number cards = face value), and dealing 10 cards to each player.

#### Scenario: Setup section visible
- **WHEN** user expands the "Setup" section
- **THEN** the section SHALL show the deck used, card point values, number of cards dealt, and how the stock and discard piles are formed

### Requirement: Rules screen displays gameplay flow
The rules screen SHALL display a section explaining the turn-by-turn gameplay: drawing from stock or discard pile, then discarding one card.

#### Scenario: Gameplay section visible
- **WHEN** user expands the "Gameplay" section
- **THEN** the section SHALL explain the draw-and-discard turn structure

### Requirement: Rules screen displays meld types
The rules screen SHALL display a section explaining the two types of melds: sets (3-4 cards of same rank) and runs (3+ consecutive cards of same suit).

#### Scenario: Melds section visible
- **WHEN** user expands the "Melds" section
- **THEN** the section SHALL explain sets and runs with examples

### Requirement: Rules screen displays knocking and gin rules
The rules screen SHALL display a section explaining knocking (ending a round with 10 or fewer deadwood points), going gin (no deadwood, 25-point bonus), and undercutting.

#### Scenario: Knocking and gin section visible
- **WHEN** user expands the "Knocking & Gin" section
- **THEN** the section SHALL explain knocking conditions, gin conditions and bonus, and undercutting

### Requirement: Rules screen displays scoring rules
The rules screen SHALL display a section explaining how scoring works: deadwood difference, gin bonus, undercut bonus, and how the app handles automatic gin bonus points.

#### Scenario: Scoring section visible
- **WHEN** user expands the "Scoring" section
- **THEN** the section SHALL explain the scoring system including the app's automatic 25-point gin bonus

### Requirement: Rules sections are collapsible
Each rules section SHALL be displayed as a collapsible/expandable section so users can focus on specific topics without scrolling through all content.

#### Scenario: Section starts collapsed
- **WHEN** user first opens the rules screen
- **THEN** all sections SHALL be displayed in collapsed state showing only their titles

#### Scenario: User expands a section
- **WHEN** user taps on a collapsed section title
- **THEN** that section SHALL expand to show its full content
