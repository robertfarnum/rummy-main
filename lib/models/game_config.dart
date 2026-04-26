import 'package:flutter/material.dart';
import '../screens/rules_screen.dart';
import '../screens/german_whist_rules_screen.dart';
import '../screens/cribbage_rules_screen.dart';
import '../screens/golf_rules_screen.dart';
import '../screens/slapjack_rules_screen.dart';
import '../screens/war_rules_screen.dart';
import '../screens/double_solitaire_rules_screen.dart';
import '../screens/crazy_eights_rules_screen.dart';

enum WinCondition { highest, lowest, winLoss }

class ScoreType {
  final String id;
  final String label;
  final int bonusPoints;

  const ScoreType(this.id, this.label, [this.bonusPoints = 0]);
}

class GameConfig {
  final String id;
  final String name;
  final int minPlayers;
  final int maxPlayers;
  final int? defaultTargetScore;
  final List<ScoreType> scoreTypes;
  final WinCondition winCondition;
  final bool hasTargetScore;
  final Widget Function() rulesScreenBuilder;

  const GameConfig({
    required this.id,
    required this.name,
    required this.minPlayers,
    required this.maxPlayers,
    this.defaultTargetScore,
    required this.scoreTypes,
    required this.winCondition,
    required this.hasTargetScore,
    required this.rulesScreenBuilder,
  });

  static List<GameConfig> get allGames => _allGames;

  static GameConfig findById(String id) {
    return _allGames.firstWhere(
      (g) => g.id == id,
      orElse: () => _allGames.first, // defaults to Gin Rummy
    );
  }

  static final List<GameConfig> _allGames = [
    GameConfig(
      id: 'gin-rummy',
      name: 'Gin Rummy',
      minPlayers: 2,
      maxPlayers: 2,
      defaultTargetScore: 100,
      scoreTypes: const [ScoreType('knock', 'Knock'), ScoreType('gin', 'Gin', 25)],
      winCondition: WinCondition.highest,
      hasTargetScore: true,
      rulesScreenBuilder: () => const RulesScreen(),
    ),
    GameConfig(
      id: 'german-whist',
      name: 'German Whist',
      minPlayers: 2,
      maxPlayers: 2,
      scoreTypes: const [ScoreType('tricks', 'Tricks Won')],
      winCondition: WinCondition.highest,
      hasTargetScore: false,
      rulesScreenBuilder: () => const GermanWhistRulesScreen(),
    ),
    GameConfig(
      id: 'cribbage',
      name: 'Cribbage',
      minPlayers: 2,
      maxPlayers: 4,
      defaultTargetScore: 121,
      scoreTypes: const [ScoreType('points', 'Points')],
      winCondition: WinCondition.highest,
      hasTargetScore: true,
      rulesScreenBuilder: () => const CribbageRulesScreen(),
    ),
    GameConfig(
      id: 'golf',
      name: 'Golf',
      minPlayers: 2,
      maxPlayers: 6,
      scoreTypes: const [ScoreType('round', 'Round Score')],
      winCondition: WinCondition.lowest,
      hasTargetScore: false,
      rulesScreenBuilder: () => const GolfRulesScreen(),
    ),
    GameConfig(
      id: 'slapjack',
      name: 'Slapjack',
      minPlayers: 2,
      maxPlayers: 8,
      scoreTypes: const [ScoreType('win', 'Game Won')],
      winCondition: WinCondition.winLoss,
      hasTargetScore: false,
      rulesScreenBuilder: () => const SlapjackRulesScreen(),
    ),
    GameConfig(
      id: 'war',
      name: 'War',
      minPlayers: 2,
      maxPlayers: 4,
      scoreTypes: const [ScoreType('win', 'Game Won')],
      winCondition: WinCondition.winLoss,
      hasTargetScore: false,
      rulesScreenBuilder: () => const WarRulesScreen(),
    ),
    GameConfig(
      id: 'double-solitaire',
      name: 'Double Solitaire',
      minPlayers: 2,
      maxPlayers: 2,
      scoreTypes: const [ScoreType('cards', 'Cards Played')],
      winCondition: WinCondition.highest,
      hasTargetScore: false,
      rulesScreenBuilder: () => const DoubleSolitaireRulesScreen(),
    ),
    GameConfig(
      id: 'crazy-eights',
      name: 'Crazy Eights',
      minPlayers: 2,
      maxPlayers: 7,
      defaultTargetScore: 100,
      scoreTypes: const [ScoreType('points', 'Points')],
      winCondition: WinCondition.highest,
      hasTargetScore: true,
      rulesScreenBuilder: () => const CrazyEightsRulesScreen(),
    ),
  ];
}
