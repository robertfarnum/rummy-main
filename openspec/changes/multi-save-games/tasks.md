## 1. Multi-game storage in Game model

- [x] 1.1 Add `int? saveIndex` field to `Game` to track position in the `saved_games` list (not serialized to JSON)
- [x] 1.2 Add static `loadAllSavedGames()` method that reads `saved_games` StringList, sets `saveIndex` on each game, and handles migration from `current_game`
- [x] 1.3 Add `saveGame()` instance method: if `saveIndex` is set, overwrite at that index; otherwise append and set `saveIndex` (enforce cap of 10)
- [x] 1.4 Add static `deleteSavedGame(int index)` method that removes the entry at `index` from the `saved_games` list
- [x] 1.5 Remove `loadCurrentGame()` and `saveCurrentGame()` methods

## 2. Update callers of old save/load methods

- [x] 2.1 Update `addRound()` and `addRoundWithTypes()` to call `saveGame()` instead of `saveCurrentGame()`
- [x] 2.2 Update `finishGame()` to call `saveGame()` instead of `saveCurrentGame()`
- [x] 2.3 Update `resetGame()` to call `saveGame()` instead of `saveCurrentGame()`

## 3. Home screen: saved games list

- [x] 3.1 Replace `Game? _savedGame` state with `List<Game> _savedGames`
- [x] 3.2 Update `_loadSavedData()` to call `Game.loadAllSavedGames()`
- [x] 3.3 Replace single saved-game card with a loop building a card for each saved game showing game type name, players, round, and target score (if applicable)
- [x] 3.4 Each saved-game card has a "Continue" button that navigates to `GameScreen` with that game
- [x] 3.5 Each saved-game card has a delete icon button

## 4. Delete confirmation dialog

- [x] 4.1 Add `_deleteSavedGame(int index, String gameName)` method that shows an `AlertDialog` asking "Delete this [Game Name] game?"
- [x] 4.2 On confirm, call `Game.deleteSavedGame(index)` and refresh `_savedGames`
- [x] 4.3 On cancel, dismiss dialog with no action

## 5. Start game and save-slot cap

- [x] 5.1 Update `_startGame()` to call `saveGame()` (append) instead of `saveCurrentGame()`
- [x] 5.2 Disable "Start Game" button when `_savedGames.length >= 10` and show a message indicating the save limit

## 6. Continue and return flow

- [x] 6.1 Update `_continueGame()` to accept a `Game` parameter (from the list) instead of using `_savedGame`
- [x] 6.2 Ensure returning from `GameScreen` calls `_loadSavedData()` to refresh the saved-games list

## 7. Verification

- [x] 7.1 Run `dart analyze` and fix any issues
- [x] 7.2 Verify migration: an app with an existing `current_game` entry shows it in the saved-games list after upgrade
- [x] 7.3 Verify starting multiple games accumulates entries in the saved-games list
- [x] 7.4 Verify deleting a saved game removes it after confirmation
