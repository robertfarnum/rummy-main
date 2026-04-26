import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/game_config.dart';

class ScoreEntryScreen extends StatefulWidget {
  final List<Player> players;
  final GameConfig gameConfig;

  const ScoreEntryScreen({super.key, required this.players, required this.gameConfig});

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
      _scoreTypes[player.name] = widget.gameConfig.scoreTypes.first.id;
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
    if (widget.gameConfig.winCondition == WinCondition.winLoss) {
      return _buildWinLossUI(context);
    }
    return _buildScoringUI(context);
  }

  Widget _buildWinLossUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Winner'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Who won this round?',
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
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final scoreData = <String, Map<String, dynamic>>{};
                        for (final p in widget.players) {
                          scoreData[p.name] = {
                            'score': p.name == player.name ? 1 : 0,
                            'type': 'win',
                          };
                        }
                        Navigator.of(context).pop(scoreData);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(player.name, style: const TextStyle(fontSize: 16)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoringUI(BuildContext context) {
    final scoreTypes = widget.gameConfig.scoreTypes;
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
                        if (scoreTypes.length > 1)
                          Row(
                            children: scoreTypes.map((st) {
                              return Expanded(
                                child: RadioListTile<String>(
                                  title: Text(
                                    st.bonusPoints > 0 ? '${st.label} (+${st.bonusPoints})' : st.label,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  value: st.id,
                                  groupValue: _scoreTypes[player.name],
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  onChanged: (value) {
                                    setState(() {
                                      _scoreTypes[player.name] = value!;
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
                                ),
                              );
                            }).toList(),
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
      final scoreType = _scoreTypes[player.name] ?? widget.gameConfig.scoreTypes.first.id;
      
      // Apply bonus points from the ScoreType config
      final st = widget.gameConfig.scoreTypes.firstWhere(
        (s) => s.id == scoreType,
        orElse: () => widget.gameConfig.scoreTypes.first,
      );
      final finalScore = score + st.bonusPoints;
      
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
