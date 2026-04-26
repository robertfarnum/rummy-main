## Why

The app currently supports only one in-progress game at a time, stored under a single `current_game` key. Starting a new game silently overwrites any existing in-progress game with no warning. Users who play multiple card games (e.g., a Cribbage game with family and a Gin Rummy game with a friend) lose their progress when switching between games.

## What Changes

- Store multiple in-progress games using indexed keys instead of a single `current_game` key
- Display a list of all saved games on the home screen, each showing the game type, players, round, and target score
- Allow users to continue any saved game or delete ones they no longer need
- Show a confirmation dialog before deleting a saved game
- Cap the number of simultaneous saved games (e.g., 10) to prevent unbounded storage growth
- Show the "New Game" setup section alongside (or below) the saved games list

## Capabilities

### New Capabilities
- `saved-game-management`: Storing, listing, loading, and deleting multiple in-progress games via SharedPreferences

### Modified Capabilities
_(none — gin-rummy-rules is about the rules screen and is unaffected)_

## Impact

- `lib/models/game.dart`: Replace `loadCurrentGame`/`saveCurrentGame` with multi-game storage methods (`saveGame`, `loadAllGames`, `deleteGame`)
- `lib/screens/home_screen.dart`: Replace single saved-game card with a scrollable list of saved games, each with continue and delete actions
- SharedPreferences storage format changes from a single `current_game` string to a `saved_games` string list — **BREAKING** for existing saved game data (migration needed for the single existing save)
