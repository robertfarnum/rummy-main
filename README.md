# Gin Rummy Scorekeeper

A cross-platform application to track scores for Gin Rummy card games. Available for mobile, web, and desktop platforms.

## Features

- Add multiple players
- Set custom target scores
- Track points for each round
- Record score types (regular, knock, gin) for detailed tracking
- View score history for each player
- See final standings and winner(s)
- Support for tie games
- Export/import game history as JSON
- Cross-platform (mobile, web, Linux desktop)

## How to Use

1. **Setup Game**:
   - Add player names
   - Set a target score (default: 100)
   - Press "Start Game" with at least 2 players

2. **During Game**:
   - Tap on a player's row to enter score for that player
   - Input points and select score type (regular, knock, or gin)
   - Tap on existing round scores to edit them if needed
   - View colored indicators for different score types

3. **Game End**:
   - Game ends when any player reaches or exceeds the target score
   - View final standings
   - Start a new game or return to home screen

## Development

### Requirements

- Flutter SDK
- Android Studio or VS Code with Flutter extensions
- For Linux: clang, cmake, ninja-build, pkg-config, libgtk-3-dev
- For Web: Chrome browser

### Running the App

#### Mobile
```bash
# Navigate to the project directory
cd rummy

# Get Flutter dependencies
flutter pub get

# Run the app on a mobile device/emulator
flutter run
```

#### Web (Chrome)
```bash
# Run on Chrome
flutter run -d chrome
```

#### Linux Desktop
```bash
# Ensure you have the required dependencies for Linux
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev

# Run on Linux desktop
flutter run -d linux
```

## Game Rules

This app only tracks scores - it doesn't enforce Gin Rummy rules. For reference:

- In Gin Rummy, the goal is to form sets or runs and "go out" by knocking or going gin
- Players receive negative points for deadwood (unmatched cards)
- The first player to reach the target score (usually 100) wins

## Score Types

The app supports three different score types:

1. **Regular**: Standard scoring when players lay down cards without going gin or knocking.

2. **Knock**: When a player "knocks" (ends the round with 10 or fewer points of deadwood).
   - The knocker scores the difference between their deadwood and opponent's deadwood.
   - If the opponent has less deadwood than the knocker, they "undercut" and score a bonus.

3. **Gin**: When a player has no deadwood (all cards are in melds).
   - They receive a bonus (usually 25 points) plus the value of the opponent's deadwood.

Score types are color-coded throughout the app:
- Regular: Default color
- Knock: Blue
- Gin: Green