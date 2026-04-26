## Context

The Gin Rummy Scorekeeper app currently has hardcoded Gin Rummy scoring throughout: score types (Knock/Gin), a +25 gin bonus, highest-score-wins logic, and a default target of 100. The app uses a screen-based navigation pattern with `Game` and `Player` models persisted via `SharedPreferences`. The proposal calls for supporting 7 additional card games, each with different scoring mechanics, player counts, and win conditions.

Key constraint: some games (Slapjack, War) have no point system — they're win/lose only. Others (Cribbage) have complex multi-type scoring. The design must accommodate this range without over-complicating simpler games.

## Goals / Non-Goals

**Goals:**
- Define a game configuration model that captures each game's rules (player range, score types, bonuses, win condition)
- Add a game selection step to the home screen before game setup
- Generalize score entry to use game-specific score types from the config
- Support both point-scoring games and win/loss-only games (Slapjack, War)
- Provide rules screens for all 7 new games
- Preserve backward compatibility with saved Gin Rummy games
- Keep the architecture simple — no abstract base classes or plugin system

**Non-Goals:**
- Game-play logic (card dealing, hand management, AI opponents)
- Real-time multiplayer or network features
- Cribbage pegging breakdown (track total points per hand, not sub-categories)
- Variant rules within a game (e.g., Oklahoma Gin, 4-player Cribbage pairs)
- Animated or interactive rule demonstrations

## Decisions

**1. Game configuration as a data class with a static registry**
- Create a `GameConfig` class in `lib/models/game_config.dart` with fields: `id` (String), `name`, `minPlayers`, `maxPlayers`, `defaultTargetScore` (nullable), `scoreTypes` (list of `ScoreType`), `winCondition` (enum: `highest`, `lowest`, `winLoss`), `hasTargetScore` (bool), `rulesScreenBuilder` (function returning a Widget)
- A static `GameConfig.allGames` list provides the registry
- Rationale: Simple, no dependencies, easily extended. A static list avoids database/config file complexity for what is a fixed set of supported games.
- Alternative considered: Abstract `Game` subclasses per game type — rejected because behavior differences are data-driven (score types, win condition), not logic-driven.

**2. ScoreType as a simple data class**
- Each `ScoreType` has: `id` (String), `label` (String), `bonusPoints` (int, default 0)
- Example: Gin Rummy has `ScoreType('knock', 'Knock', 0)` and `ScoreType('gin', 'Gin', 25)`
- For win/loss games: single `ScoreType('win', 'Game Won', 0)` — the score entry screen shows a "Mark Winner" button instead of point entry
- Rationale: Captures the existing Knock/Gin pattern and generalizes it cleanly.

**3. Win condition enum with three modes**
- `WinCondition.highest` — player with most points wins (Gin Rummy, Cribbage, German Whist, Crazy Eights, Double Solitaire)
- `WinCondition.lowest` — player with fewest points wins (Golf)
- `WinCondition.winLoss` — no cumulative scoring, just track games won (Slapjack, War)
- Rationale: These three modes cover all 8 games. The `Game.getWinners()` method switches on this enum.

**4. Game selection on home screen via dropdown or card grid**
- Add a `GameConfig` selector at the top of the home screen's game setup card, above the player fields
- Use a `DropdownButtonFormField<GameConfig>` matching the existing player dropdown style
- The selected game's config drives: player count validation, default target score, available score types
- Rationale: Consistent with existing UI patterns. A dropdown is simpler than a grid and works well for 8 games.

**5. Score entry screen driven by GameConfig.scoreTypes**
- Replace hardcoded Knock/Gin radio buttons with dynamically generated options from `game.gameConfig.scoreTypes`
- For `winLoss` games: show a simple "Select Winner" UI instead of point entry fields
- Bonus points are applied automatically based on `ScoreType.bonusPoints` (preserving existing gin +25 behavior)
- Rationale: Direct generalization of the current pattern with minimal UI changes.

**6. Game model changes — add gameType field**
- Add `gameType` (String) field to `Game`, storing the `GameConfig.id`
- Add `GameConfig get gameConfig` getter that looks up the config by id
- Default to `'gin-rummy'` for backward compatibility with saved games that lack the field
- Pass `WinCondition` to `getWinners()` logic
- Rationale: Minimal model change. String id is JSON-serializable and backward-compatible.

**7. Rules screens follow the existing pattern**
- Each game gets its own `StatelessWidget` rules screen with `ExpansionTile` sections, matching the Gin Rummy rules screen structure
- Rules screens are referenced by `GameConfig.rulesScreenBuilder` so the home screen info button and game screen can navigate to the correct rules
- Rationale: Consistent with the existing architecture. No shared base class needed since the content differs entirely.

**8. App rebranding**
- Change app title from "Gin Rummy Scorekeeper" to "Card Game Scorekeeper"
- Home screen AppBar shows "Card Game Scorekeeper"
- Rationale: Reflects multi-game support while keeping it simple.

## Risks / Trade-offs

- [Complexity of Cribbage scoring] → Mitigated by treating it as simple round-by-round point entry (players calculate and enter their total for each hand). The app doesn't need to understand pegging vs hand vs crib — just total points per round.
- [Win/loss games feel different from scoring games] → Mitigated by having a distinct "Select Winner" UI for `winLoss` games, keeping the UX clean for both modes.
- [Backward compatibility with saved games] → Mitigated by defaulting `gameType` to `'gin-rummy'` when deserializing games without the field. Existing score types ('knock', 'gin') are preserved as-is.
- [7 new rules screen files adds bulk] → Acceptable trade-off for simplicity. Each file is self-contained static content with no shared logic to extract.
- [Player count validation per game] → The home screen already validates 2–6 players. Each `GameConfig` specifies its own `minPlayers`/`maxPlayers` which replaces the hardcoded range.
