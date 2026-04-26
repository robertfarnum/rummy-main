## Context

The app currently persists a single in-progress game under the SharedPreferences key `current_game` (a JSON string). Starting a new game silently overwrites whatever is saved. Game history (completed games) uses a separate `game_history` StringList and is unaffected by this change.

The home screen shows a single "Continue" card when a saved game exists. We need to support multiple concurrent saved games so users can switch between different card games without losing progress.

## Goals / Non-Goals

**Goals:**
- Support up to 10 simultaneous in-progress games
- Migrate existing `current_game` data into the new format on first load
- List all saved games on the home screen with game type, players, round, and target
- Allow deleting individual saved games with confirmation
- Prevent starting a new game when the save-slot cap is reached

**Non-Goals:**
- Reordering or renaming saved games
- Cloud sync or cross-device save sharing
- Changing the completed-game history system (`game_history` key)
- Pausing/resuming mid-round — games already auto-save after each round

## Decisions

### 1. Storage format: `saved_games` StringList
Store all in-progress games in a single `saved_games` StringList key (each element is a JSON-encoded game). Index in the list serves as the game's identity.

**Alternatives considered:**
- Separate keys per game (`saved_game_0`, `saved_game_1`, …) — rejected because SharedPreferences has no "list keys by prefix" API, requiring a separate index key anyway.
- SQLite/Hive — overkill for ≤10 small JSON objects; adds a dependency.

### 2. Game identity: list index
Use the list index as the game identifier. When a game is deleted, remove it from the list (indices shift). The home screen reloads the full list after any mutation.

**Alternatives considered:**
- UUID per game stored in the JSON — adds complexity for no user-visible benefit at this scale.

### 3. Migration: one-time `current_game` → `saved_games`
On `loadAllSavedGames()`, if `saved_games` is empty but `current_game` exists, move it into `saved_games[0]` and delete `current_game`. This runs once per upgrade.

### 4. Save-slot cap: 10 games
`saveGame()` checks `saved_games.length < 10` before adding. The UI disables "Start Game" and shows a message when the cap is reached. 10 is generous for a casual card game app.

### 5. Home screen layout
Replace the single saved-game card with a `ListView` of saved-game cards. Each card shows:
- Game name (from `GameConfig.name`)
- Player names
- Round number and target score (if applicable)
- "Continue" button and a delete icon button

The saved-games section appears above the "New Game" setup form, same as today but supporting multiple entries.

### 6. Delete confirmation
Tapping the delete icon shows a simple `AlertDialog` confirming the action ("Delete this [Game Name] game?"). No undo — the game is removed from `saved_games` immediately.

### 7. Finished games stay until deleted
When a game finishes, it gets saved to `game_history` (existing behavior). It also remains in `saved_games` so the user can review the final state. The user can delete it manually when done, or it stays until they start enough new games to reach the cap.

## Risks / Trade-offs

- **Index-based identity is fragile if multiple widgets mutate concurrently** → Mitigated: only the home screen mutates saved games, and it reloads the full list after each change. No concurrent mutation is possible in a single-isolate Flutter app.
- **Migration loses data if `current_game` JSON is corrupt** → Mitigated: wrap in try/catch, silently discard corrupt data (same as current `loadCurrentGame` behavior).
- **10-game cap may feel arbitrary** → Acceptable: users can always delete games they're done with, and 10 concurrent card games is more than enough.
