import 'package:flutter/material.dart';
import '../models/player.dart';

class ScoreEntryScreen extends StatefulWidget {
  final List<Player> players;

  const ScoreEntryScreen({super.key, required this.players});

  @override
  State<ScoreEntryScreen> createState() => _ScoreEntryScreenState();
}

class _ScoreEntryScreenState extends State<ScoreEntryScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, FocusNode> _focusNodes = {};
  // Added map to track score types for each player
  final Map<String, String> _scoreTypes = {};
  
  @override
  void initState() {
    super.initState();
    for (final player in widget.players) {
      _controllers[player.name] = TextEditingController(text: '0');
      _focusNodes[player.name] = FocusNode();
      _scoreTypes[player.name] = 'knock'; // Default to knock instead of regular
    }
    
    // Auto-focus the first player's text field after the screen renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.players.isNotEmpty) {
        final firstPlayer = widget.players.first;
        _focusNodes[firstPlayer.name]?.requestFocus();
        _controllers[firstPlayer.name]?.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controllers[firstPlayer.name]!.text.length,
        );
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Round Scores'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter points for each player',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.players.length,
                itemBuilder: (context, index) {
                  final player = widget.players[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                player.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: _controllers[player.name],
                                focusNode: _focusNodes[player.name],
                                decoration: const InputDecoration(
                                  labelText: 'Points',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  // Select all text when the field is tapped
                                  _controllers[player.name]?.selection = TextSelection(
                                    baseOffset: 0,
                                    extentOffset: _controllers[player.name]!.text.length,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Add score type selection (removed regular option)
                        Row(
                          children: [
                            Radio<String>(
                              value: 'knock',
                              groupValue: _scoreTypes[player.name],
                              onChanged: (value) {
                                setState(() {
                                  _scoreTypes[player.name] = value!;
                                });
                              },
                            ),
                            const Text('Knock'),
                            Radio<String>(
                              value: 'gin',
                              groupValue: _scoreTypes[player.name],
                              onChanged: (value) {
                                setState(() {
                                  _scoreTypes[player.name] = value!;
                                  // Show a message when gin is selected
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('25 bonus points will be added for Gin'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                });
                              },
                            ),
                            const Text('Gin (+25)'),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _saveScores,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Save Scores'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveScores() {
    final scoreData = <String, Map<String, dynamic>>{};
    
    bool isValid = true;
    
    for (final player in widget.players) {
      final scoreText = _controllers[player.name]!.text.trim();
      if (scoreText.isEmpty) {
        isValid = false;
        break;
      }
      
      final score = int.tryParse(scoreText);
      if (score == null) {
        isValid = false;
        break;
      }
      
      // Get the score type
      final scoreType = _scoreTypes[player.name] ?? 'knock';
      
      // Add automatic bonus for gin
      final finalScore = (scoreType == 'gin') ? score + 25 : score;
      
      // Store both score and score type
      scoreData[player.name] = {
        'score': finalScore,
        'type': scoreType,
      };
    }
    
    if (isValid) {
      Navigator.of(context).pop(scoreData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid scores for all players')),
      );
    }
  }
}
