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
