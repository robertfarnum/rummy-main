## 1. Game Configuration Model

- [x] 1.1 Create `lib/models/game_config.dart` with `WinCondition` enum (`highest`, `lowest`, `winLoss`)
- [x] 1.2 Add `ScoreType` class with `id`, `label`, and `bonusPoints` fields
- [x] 1.3 Add `GameConfig` class with all required fields (`id`, `name`, `minPlayers`, `maxPlayers`, `defaultTargetScore`, `scoreTypes`, `winCondition`, `hasTargetScore`, `rulesScreenBuilder`)
- [x] 1.4 Add static `GameConfig.allGames` list with all 8 game configurations
- [x] 1.5 Add static lookup method that finds a `GameConfig` by id, defaulting to Gin Rummy

## 2. Game Model Changes

- [x] 2.1 Add `gameType` field to `Game` class, defaulting to `'gin-rummy'`
- [x] 2.2 Add `GameConfig get gameConfig` getter that looks up config by `gameType`
- [x] 2.3 Update `Game.toJson()` to include `gameType`
- [x] 2.4 Update `Game.fromJson()` to read `gameType`, defaulting to `'gin-rummy'` for backward compatibility
- [x] 2.5 Update `getWinners()` to switch on `gameConfig.winCondition` (highest, lowest, winLoss)

## 3. Home Screen Changes

- [x] 3.1 Add `GameConfig` state variable and game selection `DropdownButtonFormField` above player fields
- [x] 3.2 Wire selected game's `defaultTargetScore` to the target score field, hide field when `hasTargetScore` is false
- [x] 3.3 Update player count validation to use selected game's `minPlayers`/`maxPlayers`
- [x] 3.4 Pass `gameType` to `Game` constructor when starting a new game
- [x] 3.5 Update info button to use `selectedGame.rulesScreenBuilder` for navigation
- [x] 3.6 Update AppBar title to "Card Game Scorekeeper"

## 4. App Title Update

- [x] 4.1 Change `MaterialApp` title in `lib/main.dart` from "Gin Rummy Scorekeeper" to "Card Game Scorekeeper"

## 5. Score Entry Screen Changes

- [x] 5.1 Accept `GameConfig` (or game type) in `ScoreEntryScreen` constructor
- [x] 5.2 Replace hardcoded Knock/Gin radio buttons with dynamic score type options from `GameConfig.scoreTypes`
- [x] 5.3 Add "Select Winner" UI for `WinCondition.winLoss` games (awards 1 point to selected winner)
- [x] 5.4 Apply `ScoreType.bonusPoints` automatically when returning scores

## 6. Game Screen Changes

- [x] 6.1 Pass game config to `ScoreEntryScreen` when navigating to score entry
- [x] 6.2 Update any game-over or winner display logic to work with all win conditions

## 7. Rules Screens for New Games

- [x] 7.1 Create `lib/screens/german_whist_rules_screen.dart` with Objective, Setup, Gameplay, Scoring, and In This App sections
- [x] 7.2 Create `lib/screens/cribbage_rules_screen.dart` with Objective, Setup, Gameplay, Scoring, Winning, and In This App sections
- [x] 7.3 Create `lib/screens/golf_rules_screen.dart` with Objective, Setup, Card Values, Gameplay, and Scoring sections
- [x] 7.4 Create `lib/screens/slapjack_rules_screen.dart` with Objective, Setup, Gameplay, Winning, and In This App sections
- [x] 7.5 Create `lib/screens/war_rules_screen.dart` with Objective, Setup, Gameplay, Winning, and In This App sections
- [x] 7.6 Create `lib/screens/double_solitaire_rules_screen.dart` with Objective, Setup, Gameplay, and Scoring sections
- [x] 7.7 Create `lib/screens/crazy_eights_rules_screen.dart` with Objective, Setup, Gameplay, and Scoring sections

## 8. Wire Rules Screens to Game Configs

- [x] 8.1 Import all rules screens in `game_config.dart` and set each game's `rulesScreenBuilder` to its corresponding rules screen

## 9. Verification

- [x] 9.1 Run `dart analyze` and fix any issues
- [x] 9.2 Verify backward compatibility: existing saved games without `gameType` load as Gin Rummy
- [x] 9.3 Verify all rules screens display with collapsible ExpansionTile sections
