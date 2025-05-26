import 'package:flutter/material.dart';
import '../models/game.dart';
import '../models/player.dart';
import 'score_entry_screen.dart';
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
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('R${i+1}: ${player.gameScores[i]}', 
                                  style: const TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildPlayerScoreCard(Player player) {
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
                Text(
                  'Total: ${player.score}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (player.gameScores.isNotEmpty) ...[              
              const SizedBox(height: 8),
              const Text('History:'),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                children: player.gameScores.map((score) {
                  return Chip(
                    label: Text('$score'),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _enterRoundScores() async {
    final result = await Navigator.of(context).push<Map<String, int>>(
      MaterialPageRoute(
        builder: (context) => ScoreEntryScreen(players: widget.game.players),
      ),
    );

    if (result != null) {
      setState(() {
        widget.game.addRound(result);
      });

      if (widget.game.isGameFinished()) {
        _showGameOverScreen();
      }
    }
  }

  void _enterPlayerScore(Player player) async {
    final TextEditingController scoreController = TextEditingController(text: '0');
    
    // We need this to ensure the selection happens after the text field is rendered
    void selectAllText() {
      scoreController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: scoreController.text.length,
      );
    }
    
    final score = await showDialog<int>(
      context: context,
      builder: (context) {
        // Schedule the selection to happen after the dialog is shown
        WidgetsBinding.instance.addPostFrameCallback((_) => selectAllText());
        
        return AlertDialog(
          title: Text('Enter Score for ${player.name}'),
          content: TextField(
            controller: scoreController,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Points',
              border: OutlineInputBorder(),
            ),
            onTap: selectAllText,
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
                  Navigator.of(context).pop(score);
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
      },
    );

    if (score != null) {
      final scores = <String, int>{};
      
      // Add the score for this player
      scores[player.name] = score;
      
      // Set score of 0 for all other players in this round
      for (final p in widget.game.players) {
        if (p.name != player.name) {
          scores[p.name] = 0;
        }
      }
      
      setState(() {
        widget.game.addRound(scores);
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
    final TextEditingController scoreController = TextEditingController(text: player.gameScores[roundIndex].toString());
    
    // We need this to ensure the selection happens after the text field is rendered
    void selectAllText() {
      scoreController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: scoreController.text.length,
      );
    }
    
    final score = await showDialog<int>(
      context: context,
      builder: (context) {
        // Schedule the selection to happen after the dialog is shown
        WidgetsBinding.instance.addPostFrameCallback((_) => selectAllText());
        
        return AlertDialog(
          title: Text('Edit Score for ${player.name} (Round ${roundIndex + 1})'),
          content: TextField(
            controller: scoreController,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Points',
              border: OutlineInputBorder(),
            ),
            onTap: selectAllText,
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
                  Navigator.of(context).pop(score);
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
      },
    );

    if (score != null) {
      setState(() {
        // Use the new editRoundScore method to properly update the score
        player.editRoundScore(roundIndex, score);
        
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
