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
  
  @override
  void initState() {
    super.initState();
    for (final player in widget.players) {
      _controllers[player.name] = TextEditingController(text: '0');
      _focusNodes[player.name] = FocusNode();
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
    _controllers.values.forEach((controller) => controller.dispose());
    _focusNodes.values.forEach((focusNode) => focusNode.dispose());
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
                    child: Row(
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
    final scores = <String, int>{};
    
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
      
      scores[player.name] = score;
    }
    
    if (isValid) {
      Navigator.of(context).pop(scores);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid scores for all players')),
      );
    }
  }
}
