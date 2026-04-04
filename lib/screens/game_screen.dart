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
    if (index >= player.scoreTypes.length) return Colors.blueAccent.shade100; // Default to knock color

    switch (player.scoreTypes[index]) {
      case 'regular': // Keep support for legacy data
        return Theme.of(context).colorScheme.primaryContainer;
      case 'knock':
        return Colors.blueAccent.shade100;
      case 'gin':
        return Colors.greenAccent.shade100;
      default:
        return Colors.blueAccent.shade100; // Default to knock color
    }
  }

  // Helper method to get a suffix for the score based on type
  String _getScoreTypeSuffix(Player player, int index) {
    if (index >= player.scoreTypes.length) return '';

    switch (player.scoreTypes[index]) {
      case 'regular': // Keep support for legacy data
        return '';
      case 'knock':
        return ' (K)';
      case 'gin':
        return ' (G+25)'; // Make it clear there's a +25 bonus
      default:
        return '';
    }
  }

  void _enterPlayerScore(Player player) async {
    final TextEditingController scoreController = TextEditingController(text: '0');
    String scoreType = 'knock'; // Default score type (now using knock as default instead of regular)
    
    // We need this to ensure the selection happens after the text field is rendered
    void selectAllText() {
      scoreController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: scoreController.text.length,
      );
    }
    
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        // Schedule the selection to happen after the dialog is shown
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
                  const SizedBox(height: 16),
                  const Text('Score Type:'),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'knock',
                        groupValue: scoreType,
                        onChanged: (value) {
                          setState(() => scoreType = value!);
                        },
                      ),
                      const Text('Knock'),
                      Radio<String>(
                        value: 'gin',
                        groupValue: scoreType,
                        onChanged: (value) {
                          setState(() {
                            scoreType = value!;
                            // If Gin is selected, show info about automatic bonus
                            if (scoreType == 'gin') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('25 bonus points will be added for Gin'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          });
                        },
                      ),
                      const Text('Gin (+25)'),
                    ],
                  ),
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
      
      // Add the score for this player, with automatic bonus for gin
      final scoreValue = result['score'] as int;
      final scoreType = result['type'] as String;
      final finalScore = (scoreType == 'gin') ? scoreValue + 25 : scoreValue;
      
      scoreData[player.name] = {
        'score': finalScore,
        'type': scoreType,
      };
      
      // Set score of 0 for all other players in this round
      for (final p in widget.game.players) {
        if (p.name != player.name) {
          scoreData[p.name] = {
            'score': 0,
            'type': 'knock', // Updated default from regular to knock
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
    // If this was a gin round, we need to adjust the displayed score (subtract 25)
    final currentScoreType = roundIndex < player.scoreTypes.length ? player.scoreTypes[roundIndex] : 'knock';
    final displayedScore = player.gameScores[roundIndex];
    
    // For gin rounds, subtract the 25 bonus points from the display to show original value
    final adjustedScoreForDisplay = currentScoreType == 'gin' ? displayedScore - 25 : displayedScore;
    
    final TextEditingController scoreController = TextEditingController(text: adjustedScoreForDisplay.toString());
    String scoreType = currentScoreType;
    
    // We need this to ensure the selection happens after the text field is rendered
    void selectAllText() {
      scoreController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: scoreController.text.length,
      );
    }
    
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        // Schedule the selection to happen after the dialog is shown
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
                  const SizedBox(height: 16),
                  const Text('Score Type:'),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'knock',
                        groupValue: scoreType,
                        onChanged: (value) {
                          setState(() => scoreType = value!);
                        },
                      ),
                      const Text('Knock'),
                      Radio<String>(
                        value: 'gin',
                        groupValue: scoreType,
                        onChanged: (value) {
                          setState(() {
                            scoreType = value!;
                            // If Gin is selected, show info about automatic bonus
                            if (scoreType == 'gin') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('25 bonus points will be added for Gin'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          });
                        },
                      ),
                      const Text('Gin (+25)'),
                    ],
                  ),
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
        // Get the entered score and type
        final scoreValue = result['score'] as int;
        final scoreType = result['type'] as String;
        
        // Add automatic bonus for gin
        final finalScore = (scoreType == 'gin') ? scoreValue + 25 : scoreValue;
        
        // Use the new editRoundScoreWithType method to properly update the score and type
        player.editRoundScoreWithType(roundIndex, finalScore, scoreType);
        
        // Save the updated game state
        widget.game.saveCurrentGame();
        
        // Check if game is finished after score update
        if (widget.game.isGameFinished()) {
          _showGameOverScreen();
        }
      });
    }
  }
}
