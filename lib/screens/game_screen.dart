import 'package:flutter/material.dart';
import '../models/game.dart';
import '../models/player.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  final Game game;

  const GameScreen({super.key, required this.game});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Progress'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Round: ${widget.game.currentRound}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Target: ${widget.game.targetScore}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildPlayerList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerList() {
    return ListView.builder(
      itemCount: widget.game.players.length,
      itemBuilder: (context, index) {
        final player = widget.game.players[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      player.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          'Total: ${player.score}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => _enterPlayerScore(player),
                          child: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ],
                ),
                if (player.gameScores.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text('Round Scores:'),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: player.gameScores.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () => _editRoundScore(player, i),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getScoreTypeColor(player, i, context),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'R${i+1}: ${player.gameScores[i]}${_getScoreTypeSuffix(player, i)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to get the appropriate score type color
  Color _getScoreTypeColor(Player player, int index, BuildContext context) {
    if (index >= player.scoreTypes.length) return Theme.of(context).colorScheme.primaryContainer;

    final scoreTypeId = player.scoreTypes[index];
    final gameConfig = widget.game.gameConfig;
    final stIndex = gameConfig.scoreTypes.indexWhere((st) => st.id == scoreTypeId);
    
    // Use a set of distinct colors based on score type index
    const colors = [Colors.blueAccent, Colors.greenAccent, Colors.orangeAccent, Colors.purpleAccent];
    if (stIndex >= 0 && stIndex < colors.length) {
      return colors[stIndex].shade100;
    }
    return Theme.of(context).colorScheme.primaryContainer;
  }

  // Helper method to get a suffix for the score based on type
  String _getScoreTypeSuffix(Player player, int index) {
    if (index >= player.scoreTypes.length) return '';

    final scoreTypeId = player.scoreTypes[index];
    final gameConfig = widget.game.gameConfig;
    final st = gameConfig.scoreTypes.where((s) => s.id == scoreTypeId).firstOrNull;
    if (st == null) return '';
    
    if (st.bonusPoints > 0) {
      return ' (${st.label.substring(0, 1)}+${st.bonusPoints})';
    }
    if (gameConfig.scoreTypes.length > 1) {
      return ' (${st.label.substring(0, 1)})';
    }
    return '';
  }

  void _enterPlayerScore(Player player) async {
    final gameConfig = widget.game.gameConfig;
    final TextEditingController scoreController = TextEditingController(text: '0');
    String scoreType = gameConfig.scoreTypes.first.id;
    
    void selectAllText() {
      scoreController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: scoreController.text.length,
      );
    }
    
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) => selectAllText());
        
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Enter Score for ${player.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: scoreController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Points',
                      border: OutlineInputBorder(),
                    ),
                    onTap: selectAllText,
                  ),
                  if (gameConfig.scoreTypes.length > 1) ...[
                    const SizedBox(height: 16),
                    const Text('Score Type:'),
                    ...gameConfig.scoreTypes.map((st) {
                      return RadioListTile<String>(
                        title: Text(
                          st.bonusPoints > 0 ? '${st.label} (+${st.bonusPoints})' : st.label,
                        ),
                        value: st.id,
                        groupValue: scoreType,
                        dense: true,
                        onChanged: (value) {
                          setState(() {
                            scoreType = value!;
                            if (st.bonusPoints > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${st.bonusPoints} bonus points will be added for ${st.label}'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          });
                        },
                      );
                    }),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    final scoreText = scoreController.text.trim();
                    final score = int.tryParse(scoreText);
                    if (score != null) {
                      Navigator.of(context).pop({
                        'score': score,
                        'type': scoreType,
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid score')),
                      );
                    }
                  },
                  child: const Text('SAVE'),
                ),
              ],
            );
          }
        );
      },
    );

    if (result != null) {
      final scoreData = <String, Map<String, dynamic>>{};
      
      final scoreValue = result['score'] as int;
      final resultType = result['type'] as String;
      final st = gameConfig.scoreTypes.firstWhere(
        (s) => s.id == resultType,
        orElse: () => gameConfig.scoreTypes.first,
      );
      final finalScore = scoreValue + st.bonusPoints;
      
      scoreData[player.name] = {
        'score': finalScore,
        'type': resultType,
      };
      
      for (final p in widget.game.players) {
        if (p.name != player.name) {
          scoreData[p.name] = {
            'score': 0,
            'type': gameConfig.scoreTypes.first.id,
          };
        }
      }
      
      setState(() {
        widget.game.addRoundWithTypes(scoreData);
      });
      
      if (widget.game.isGameFinished()) {
        _showGameOverScreen();
      }
    }
  }

  void _showGameOverScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GameOverScreen(game: widget.game),
      ),
    );
  }

  void _editRoundScore(Player player, int roundIndex) async {
    final gameConfig = widget.game.gameConfig;
    final currentScoreType = roundIndex < player.scoreTypes.length ? player.scoreTypes[roundIndex] : gameConfig.scoreTypes.first.id;
    final displayedScore = player.gameScores[roundIndex];
    
    // For score types with bonuses, subtract bonus for display
    final st = gameConfig.scoreTypes.where((s) => s.id == currentScoreType).firstOrNull;
    final adjustedScoreForDisplay = (st != null && st.bonusPoints > 0) ? displayedScore - st.bonusPoints : displayedScore;
    
    final TextEditingController scoreController = TextEditingController(text: adjustedScoreForDisplay.toString());
    String scoreType = currentScoreType;
    
    void selectAllText() {
      scoreController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: scoreController.text.length,
      );
    }
    
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) => selectAllText());
        
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Score for ${player.name} (Round ${roundIndex + 1})'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: scoreController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Points',
                      border: OutlineInputBorder(),
                    ),
                    onTap: selectAllText,
                  ),
                  if (gameConfig.scoreTypes.length > 1) ...[
                    const SizedBox(height: 16),
                    const Text('Score Type:'),
                    ...gameConfig.scoreTypes.map((scoreSt) {
                      return RadioListTile<String>(
                        title: Text(
                          scoreSt.bonusPoints > 0 ? '${scoreSt.label} (+${scoreSt.bonusPoints})' : scoreSt.label,
                        ),
                        value: scoreSt.id,
                        groupValue: scoreType,
                        dense: true,
                        onChanged: (value) {
                          setState(() {
                            scoreType = value!;
                            if (scoreSt.bonusPoints > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${scoreSt.bonusPoints} bonus points will be added for ${scoreSt.label}'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          });
                        },
                      );
                    }),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    final scoreText = scoreController.text.trim();
                    final score = int.tryParse(scoreText);
                    if (score != null) {
                      Navigator.of(context).pop({
                        'score': score,
                        'type': scoreType,
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid score')),
                      );
                    }
                  },
                  child: const Text('SAVE'),
                ),
              ],
            );
          }
        );
      },
    );

    if (result != null) {
      setState(() {
        final scoreValue = result['score'] as int;
        final resultType = result['type'] as String;
        
        // Apply bonus from config
        final editSt = gameConfig.scoreTypes.firstWhere(
          (s) => s.id == resultType,
          orElse: () => gameConfig.scoreTypes.first,
        );
        final finalScore = scoreValue + editSt.bonusPoints;
        
        player.editRoundScoreWithType(roundIndex, finalScore, resultType);
        widget.game.saveGame();
        
        if (widget.game.isGameFinished()) {
          _showGameOverScreen();
        }
      });
    }
  }
}
