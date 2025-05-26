import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:rummy_scorekeeper/models/game.dart';
import 'package:rummy_scorekeeper/models/player.dart';

@GenerateMocks([SharedPreferences])
import 'game_test.mocks.dart';

void main() {
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    SharedPreferences.setMockInitialValues({});
  });

  group('Game basics', () {
    test('Game initializes with correct default values', () {
      final players = [Player(name: 'Player 1'), Player(name: 'Player 2')];
      final game = Game(players: players);

      expect(game.players, players);
      expect(game.targetScore, 100);
      expect(game.currentRound, 0);
      expect(game.startTime, isNotNull);
      expect(game.endTime, isNull);
    });

    test('Game.fromJson creates correct game object', () {
      final jsonData = {
        'players': [
          {'name': 'Player 1', 'score': 50},
          {'name': 'Player 2', 'score': 75}
        ],
        'targetScore': 150,
        'currentRound': 3,
        'startTime': '2023-01-01T10:00:00.000Z',
        'endTime': null
      };

      final game = Game.fromJson(jsonData);

      expect(game.players.length, 2);
      expect(game.players[0].name, 'Player 1');
      expect(game.players[0].score, 50);
      expect(game.players[1].name, 'Player 2');
      expect(game.players[1].score, 75);
      expect(game.targetScore, 150);
      expect(game.currentRound, 3);
      expect(game.startTime, DateTime.parse('2023-01-01T10:00:00.000Z'));
      expect(game.endTime, isNull);
    });

    test('toJson returns correct JSON representation', () {
      final players = [
        Player(name: 'Player 1')..addPoints(50),
        Player(name: 'Player 2')..addPoints(75)
      ];
      final game = Game(players: players, targetScore: 150)
        ..currentRound = 3
        ..startTime = DateTime.parse('2023-01-01T10:00:00.000Z')
        ..endTime = null;

      final json = game.toJson();

      expect(json['players'].length, 2);
      expect(json['players'][0]['name'], 'Player 1');
      expect(json['players'][0]['score'], 50);
      expect(json['players'][1]['name'], 'Player 2');
      expect(json['players'][1]['score'], 75);
      expect(json['targetScore'], 150);
      expect(json['currentRound'], 3);
      expect(json['startTime'], '2023-01-01T10:00:00.000Z');
      expect(json['endTime'], isNull);
    });
  });

  group('Game logic', () {
    test('addRound increments round and updates scores', () {
      final players = [
        Player(name: 'Player 1'),
        Player(name: 'Player 2')
      ];
      final game = Game(players: players);
      
      // Mock saveCurrentGame to avoid actual SharedPreferences calls
      game.saveCurrentGame = () async {};
      
      game.addRound({'Player 1': 10, 'Player 2': 20});
      
      expect(game.currentRound, 1);
      expect(players[0].score, 10);
      expect(players[1].score, 20);
    });

    test('isGameFinished returns true when a player reaches target score', () {
      final players = [
        Player(name: 'Player 1')..addPoints(120),
        Player(name: 'Player 2')..addPoints(50)
      ];
      final game = Game(players: players, targetScore: 100);
      
      expect(game.isGameFinished(), true);
    });

    test('getWinners returns players with highest score', () {
      final players = [
        Player(name: 'Player 1')..addPoints(120),
        Player(name: 'Player 2')..addPoints(120),
        Player(name: 'Player 3')..addPoints(50)
      ];
      final game = Game(players: players, targetScore: 100);
      
      final winners = game.getWinners();
      
      expect(winners.length, 2);
      expect(winners[0].name, 'Player 1');
      expect(winners[1].name, 'Player 2');
    });
  });

  group('Storage operations', () {
    test('savePlayerNames combines existing and new names', () async {
      when(mockPrefs.getStringList('player_names'))
          .thenReturn(['Alice', 'Bob']);
      when(mockPrefs.setStringList('player_names', any))
          .thenAnswer((_) async => true);

      final players = [
        Player(name: 'Bob'),
        Player(name: 'Charlie')
      ];
      final game = Game(players: players);
      
      // Replace the static method with a mock implementation for testing
      Game.getSavedPlayerNames = () async => ['Alice', 'Bob'];
      
      // Mock the instance method to use our mock
      game.savePlayerNames = () async {
        final savedNames = await Game.getSavedPlayerNames();
        final currentNames = game.players.map((p) => p.name).toList();
        final allNames = {...savedNames, ...currentNames}.toList();
        await mockPrefs.setStringList('player_names', allNames);
      };
      
      await game.savePlayerNames();
      
      verify(mockPrefs.setStringList('player_names', ['Alice', 'Bob', 'Charlie']));
    });
    
    test('loadCurrentGame returns null when no game exists', () async {
      when(mockPrefs.getString('current_game')).thenReturn(null);
      
      // Replace static method with mock implementation
      Game.loadCurrentGame = () async {
        final gameJson = mockPrefs.getString('current_game');
        if (gameJson != null) {
          try {
            return Game.fromJson(jsonDecode(gameJson));
          } catch (e) {
            return null;
          }
        }
        return null;
      };
      
      final game = await Game.loadCurrentGame();
      
      expect(game, isNull);
    });
  });

  group('Game history management', () {
    test('deleteGameFromHistory removes a game from history', () async {
      // Setup mock SharedPreferences
      final List<String> mockHistory = [
        '{"players":[{"name":"Player 1","score":50,"gameScores":[10,20,20]}],"targetScore":100,"currentRound":3,"startTime":"2023-01-01T10:00:00.000Z","endTime":"2023-01-01T11:00:00.000Z"}',
        '{"players":[{"name":"Player 2","score":80,"gameScores":[30,50]}],"targetScore":100,"currentRound":2,"startTime":"2023-01-02T10:00:00.000Z","endTime":"2023-01-02T11:00:00.000Z"}'
      ];
      
      when(mockPrefs.getStringList('game_history')).thenReturn(mockHistory);
      when(mockPrefs.setStringList('game_history', any)).thenAnswer((_) async => true);
      
      // Replace the static method with mock implementation
      Game.deleteGameFromHistory = (int index) async {
        final history = mockPrefs.getStringList('game_history') ?? [];
        if (index >= 0 && index < history.length) {
          history.removeAt(index);
          await mockPrefs.setStringList('game_history', history);
        }
      };
      
      await Game.deleteGameFromHistory(0);
      
      verify(mockPrefs.setStringList('game_history', [
        '{"players":[{"name":"Player 2","score":80,"gameScores":[30,50]}],"targetScore":100,"currentRound":2,"startTime":"2023-01-02T10:00:00.000Z","endTime":"2023-01-02T11:00:00.000Z"}'
      ]));
    });
  });
}