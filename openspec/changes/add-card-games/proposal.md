## Why

The app currently only supports Gin Rummy scoring. Users who play other card games need a separate app or manual tracking. Expanding to support additional card games (German Whist, Cribbage, Golf, Slapjack, War, Double Solitaire, Crazy Eights) makes the app a general-purpose card game scorekeeper, increasing its usefulness and audience.

## What Changes

- Add a game selection menu so users choose which card game to play before setting up a new game
- Define game-specific scoring rules, score types, and win conditions for each supported game
- Add rules screens for each new game (same collapsible ExpansionTile pattern as Gin Rummy)
- Generalize the scoring entry screen to support game-specific score types instead of hardcoded Knock/Gin
- Generalize win condition logic (some games use highest score wins, others use lowest)
- Update the app title and branding to reflect multi-game support
- Preserve full backward compatibility with existing Gin Rummy scoring and saved game data

## Capabilities

### New Capabilities
- `game-registry`: Central registry of supported card games with their configuration (name, player count range, scoring types, win condition, target score default, bonus rules)
- `game-selection`: Game selection menu on the home screen allowing users to pick a card game before starting
- `german-whist-rules`: Rules screen for German Whist
- `cribbage-rules`: Rules screen for Cribbage
- `golf-rules`: Rules screen for Golf (card game)
- `slapjack-rules`: Rules screen for Slapjack
- `war-rules`: Rules screen for War
- `double-solitaire-rules`: Rules screen for Double Solitaire
- `crazy-eights-rules`: Rules screen for Crazy Eights

### Modified Capabilities
- `gin-rummy-rules`: Add navigation from the game-specific rules button (currently accessed from home screen info button; will also be accessible from game context)

## Impact

- **New file**: `lib/models/game_config.dart` — game configuration model and registry
- **New files**: `lib/screens/*_rules_screen.dart` — rules screens for each new game (7 files)
- **Modified file**: `lib/main.dart` — update app title
- **Modified file**: `lib/screens/home_screen.dart` — add game selection before game setup
- **Modified file**: `lib/screens/score_entry_screen.dart` — use game-specific score types instead of hardcoded Knock/Gin
- **Modified file**: `lib/models/game.dart` — add game type field, generalize win condition logic
- **Modified file**: `lib/models/player.dart` — support game-specific score type strings
- No new dependencies required; uses existing Flutter Material widgets
