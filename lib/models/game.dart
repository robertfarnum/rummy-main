import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'player.dart';

class Game {
  List<Player> players;
  int targetScore;
  int currentRound;
  DateTime? startTime;
  DateTime? endTime;
  
  Game({required this.players, this.targetScore = 100}) 
    : currentRound = 0,
      startTime = DateTime.now();

  // Constructor for restoring from storage
  Game.fromJson(Map<String, dynamic> json)
      : players = (json['players'] as List).map((p) => Player.fromJson(p)).toList(),
        targetScore = json['targetScore'],
        currentRound = json['currentRound'],
        startTime = json['startTime'] != null ? DateTime.parse(json['startTime']) : null,
        endTime = json['endTime'] != null ? DateTime.parse(json['endTime']) : null;

  // Convert game to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'players': players.map((p) => p.toJson()).toList(),
      'targetScore': targetScore,
      'currentRound': currentRound,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
    };
  }

  void addRound(Map<String, int> scores) {
    currentRound++;
    scores.forEach((playerName, score) {
      final player = players.firstWhere((p) => p.name == playerName);
      player.addPoints(score);
    });
    saveCurrentGame();
  }
  
  // New method to add a round with score types
  void addRoundWithTypes(Map<String, Map<String, dynamic>> scoreData) {
    currentRound++;
    scoreData.forEach((playerName, data) {
      final player = players.firstWhere((p) => p.name == playerName);
      final score = data['score'] as int;
      final scoreType = data['type'] as String;
      player.addPointsWithType(score, scoreType);
    });
    saveCurrentGame();
  }

  bool isGameFinished() {
    return players.any((player) => player.score >= targetScore);
  }

  List<Player> getWinners() {
    if (!isGameFinished()) return [];
    
    final highestScore = players.map((p) => p.score).reduce(
      (value, element) => value > element ? value : element
    );
    
    return players.where((p) => p.score == highestScore).toList();
  }

  void finishGame() {
    if (isGameFinished() && endTime == null) {
      endTime = DateTime.now();
      saveGameHistory();
      saveCurrentGame();
    }
  }

  void resetGame() {
    for (final player in players) {
      player.resetScore();
    }
    currentRound = 0;
    startTime = DateTime.now();
    endTime = null;
    saveCurrentGame();
  }

  // Save current game state to SharedPreferences
  Future<void> saveCurrentGame() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_game', jsonEncode(toJson()));
  }

  // Save completed game to history
  Future<void> saveGameHistory() async {
    if (endTime == null) return;
    
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('game_history') ?? [];
    
    // Add current game to history
    history.add(jsonEncode(toJson()));
    
    // Save updated history
    await prefs.setStringList('game_history', history);
  }

  // Load current game from SharedPreferences
  static Future<Game?> loadCurrentGame() async {
    final prefs = await SharedPreferences.getInstance();
    final gameJson = prefs.getString('current_game');
    
    if (gameJson != null) {
      try {
        return Game.fromJson(jsonDecode(gameJson));
      } catch (e) {
        print('Error loading current game: $e');
        return null;
      }
    }
    return null;
  }

  // Load game history from SharedPreferences
  static Future<List<Game>> loadGameHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('game_history') ?? [];
    
    return history.map((gameJson) {
      try {
        return Game.fromJson(jsonDecode(gameJson));
      } catch (e) {
        print('Error loading game from history: $e');
        return null;
      }
    }).whereType<Game>().toList();
  }

  // Get all previously used player names
  static Future<List<String>> getSavedPlayerNames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('player_names') ?? [];
  }

  // Save player names for future use
  Future<void> savePlayerNames() async {
    final prefs = await SharedPreferences.getInstance();
    final savedNames = await getSavedPlayerNames();
    final currentNames = players.map((p) => p.name).toList();
    
    // Combine existing and new names, ensure uniqueness
    final allNames = {...savedNames, ...currentNames}.toList();
    
    await prefs.setStringList('player_names', allNames);
  }

  // Save a list of player names directly
  static Future<bool> savePlayerNamesList(List<String> playerNames) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList('player_names', playerNames);
  }

  // Delete a game from history at the specified index
  static Future<bool> deleteGameFromHistory(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('game_history') ?? [];
    
    if (index < 0 || index >= history.length) {
      return false;
    }
    
    history.removeAt(index);
    return await prefs.setStringList('game_history', history);
  }

  // Export all game history as a JSON string
  static Future<String> exportGameHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('game_history') ?? [];
    
    // Create a JSON object with version info and the history array
    final exportData = {
      'version': '1.0',
      'exportDate': DateTime.now().toIso8601String(),
      'games': history.map((gameJson) => jsonDecode(gameJson)).toList(),
    };
    
    // Convert to pretty-printed JSON
    return const JsonEncoder.withIndent('  ').convert(exportData);
  }
  
  // Import game history from JSON string
  static Future<int> importGameHistory(String jsonData) async {
    try {
      // Validate the data format
      if (!isValidGameHistoryJson(jsonData)) {
        throw FormatException('Invalid game history format');
      }
      
      // Parse the JSON
      final Map<String, dynamic> importData = jsonDecode(jsonData);
      final List<dynamic> games = importData['games'];
      
      // Get existing history
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList('game_history') ?? [];
      
      // Convert current history to game objects for duplicate checking
      final existingGames = history.map((json) => jsonDecode(json)).toList();
      
      // Add each game to history if it's not a duplicate
      int importCount = 0;
      for (final game in games) {
        try {
          // Check if this game already exists
          bool isDuplicate = existingGames.any((existing) {
            // Compare essential properties to detect duplicates
            // This is a simplistic approach; a more robust solution might be needed
            return existing['startTime'] == game['startTime'] &&
                   existing['targetScore'] == game['targetScore'] &&
                   existing['currentRound'] == game['currentRound'];
          });
          
          if (!isDuplicate) {
            // Convert to JSON string for storage
            final gameJson = jsonEncode(game);
            history.add(gameJson);
            importCount++;
          }
        } catch (e) {
          print('Error importing individual game: $e');
          // Skip invalid games
        }
      }
      
      // Save updated history
      await prefs.setStringList('game_history', history);
      
      return importCount;
    } catch (e) {
      print('Error importing game history: $e');
      return 0;
    }
  }

  // Validate if a string is valid game history JSON
  static bool isValidGameHistoryJson(String jsonData) {
    try {
      final Map<String, dynamic> data = jsonDecode(jsonData);
      
      // Check for games array
      if (!data.containsKey('games') || data['games'] is! List) {
        return false;
      }
      
      // Check version compatibility if needed
      if (data.containsKey('version')) {
        final version = data['version'];
        // For now we only have version 1.0, but in the future we can check for compatibility
        if (version != '1.0') {
          print('Warning: Importing from unknown version: $version');
        }
      }
      
      // Check each game in the array
      final games = data['games'] as List;
      for (final game in games) {
        if (game is! Map<String, dynamic>) {
          return false;
        }
        
        // Check required game properties
        if (!game.containsKey('players') || !game.containsKey('targetScore') || 
            !game.containsKey('currentRound')) {
          return false;
        }
      }
      
      return true;
    } catch (e) {
      print('Error validating game history JSON: $e');
      return false;
    }
  }

  void addPlayer(Player player) {
    if (!players.contains(player)) {
      players.add(player);
    }
  }

  void removePlayer(Player player) {
    if (players.length > 2) {
      players.remove(player);
    }
  }
}
