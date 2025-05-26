# Gin Rummy Scorekeeper

A cross-platform application to track scores for Gin Rummy card games. Available for mobile, web, and desktop platforms.

## Features

- Add multiple players
- Set custom target scores
- Track points for each round
- View score history for each player
- See final standings and winner(s)
- Support for tie games
- Cross-platform (mobile, web, Linux desktop)

## How to Use

1. **Setup Game**:
   - Add player names
   - Set a target score (default: 100)
   - Press "Start Game" with at least 2 players

2. **During Game**:
   - Press "Enter Round Scores" after each round
   - Input points for each player
   - Save scores to update the game

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