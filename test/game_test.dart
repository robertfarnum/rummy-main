import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:rummy_scorekeeper/models/game.dart';
import 'package:rummy_scorekeeper/models/player.dart';

void main() {
  setUp(() {
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
          {'name': 'Player 1', 'score': 50, 'gameScores': [50], 'scoreTypes': ['regular']},
          {'name': 'Player 2', 'score': 75, 'gameScores': [75], 'scoreTypes': ['regular']}
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
    test('addRound increments round and updates scores', () async {
      SharedPreferences.setMockInitialValues({});
      final players = [
        Player(name: 'Player 1'),
        Player(name: 'Player 2')
      ];
      final game = Game(players: players);

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
      SharedPreferences.setMockInitialValues({
        'player_names': ['Alice', 'Bob'],
      });

      final players = [
        Player(name: 'Bob'),
        Player(name: 'Charlie')
      ];
      final game = Game(players: players);

      await game.savePlayerNames();

      final prefs = await SharedPreferences.getInstance();
      final savedNames = prefs.getStringList('player_names')!;
      expect(savedNames, containsAll(['Alice', 'Bob', 'Charlie']));
      expect(savedNames.length, 3);
    });

    test('loadCurrentGame returns null when no game exists', () async {
      SharedPreferences.setMockInitialValues({});

      final game = await Game.loadCurrentGame();

      expect(game, isNull);
    });
  });

  group('Game history management', () {
    test('deleteGameFromHistory removes a game from history', () async {
      final history = [
        '{"players":[{"name":"Player 1","score":50,"gameScores":[10,20,20],"scoreTypes":["regular","regular","regular"]}],"targetScore":100,"currentRound":3,"startTime":"2023-01-01T10:00:00.000Z","endTime":"2023-01-01T11:00:00.000Z"}',
        '{"players":[{"name":"Player 2","score":80,"gameScores":[30,50],"scoreTypes":["regular","regular"]}],"targetScore":100,"currentRound":2,"startTime":"2023-01-02T10:00:00.000Z","endTime":"2023-01-02T11:00:00.000Z"}'
      ];

      SharedPreferences.setMockInitialValues({
        'game_history': history,
      });

      await Game.deleteGameFromHistory(0);

      final prefs = await SharedPreferences.getInstance();
      final remaining = prefs.getStringList('game_history')!;
      expect(remaining.length, 1);
      expect(jsonDecode(remaining[0])['players'][0]['name'], 'Player 2');
    });
  });
}