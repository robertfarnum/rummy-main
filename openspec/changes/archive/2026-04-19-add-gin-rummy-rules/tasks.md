## 1. Create Rules Screen

- [x] 1.1 Create `lib/screens/rules_screen.dart` with a `RulesScreen` StatelessWidget
- [x] 1.2 Add AppBar with title "How to Play Gin Rummy" and back navigation
- [x] 1.3 Add Objective ExpansionTile section with game goal content
- [x] 1.4 Add Setup ExpansionTile section with deck, card values, dealing, stock/discard pile content
- [x] 1.5 Add Gameplay ExpansionTile section with draw-and-discard turn structure content
- [x] 1.6 Add Melds ExpansionTile section with sets and runs explanations and examples
- [x] 1.7 Add Knocking & Gin ExpansionTile section with knocking conditions, gin bonus, and undercutting content
- [x] 1.8 Add Scoring ExpansionTile section with deadwood difference, gin bonus, undercut bonus, and app-specific automatic gin bonus note

## 2. Update Home Screen Navigation

- [x] 2.1 Import `rules_screen.dart` in `home_screen.dart`
- [x] 2.2 Replace `_showScoringInfo` dialog method with `Navigator.push` to `RulesScreen`
- [x] 2.3 Update info button tooltip from "Scoring Information" to "How to Play"

## 3. Verify

- [x] 3.1 Run `dart analyze` to confirm no issues
- [x] 3.2 Verify all ExpansionTile sections start collapsed and expand on tap
