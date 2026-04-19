## Why

Users of the Gin Rummy Scorekeeper app may not know how to play Gin Rummy. Currently the app only shows a brief scoring types dialog (Knock vs Gin). Adding complete game rules educates users and makes the app more useful as a self-contained companion for playing Gin Rummy.

## What Changes

- Expand the existing scoring information dialog into a full rules screen that covers how to play Gin Rummy
- Add a new dedicated screen accessible from the home screen info button that includes: objective, setup, gameplay, melds, knocking, gin, scoring, and winning
- Replace the current simple AlertDialog with navigation to the new rules screen

## Capabilities

### New Capabilities
- `gin-rummy-rules`: A dedicated screen presenting the complete rules of Gin Rummy, including objective, card setup, gameplay flow, forming melds (sets and runs), knocking, gin, scoring, and how to win

### Modified Capabilities

## Impact

- **New file**: `lib/screens/rules_screen.dart` — new screen widget for displaying rules
- **Modified file**: `lib/screens/home_screen.dart` — update the info button to navigate to the rules screen instead of showing a dialog
- No new dependencies required; uses only existing Flutter Material widgets
