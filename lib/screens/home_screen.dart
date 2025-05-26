import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/game.dart';
import 'game_screen.dart';
import 'history_screen.dart';
import 'player_management_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Player> _players = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _targetScoreController = TextEditingController(text: '100');
  List<String> _savedPlayerNames = [];
  Game? _savedGame;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    setState(() {
      _isLoading = true;
    });

    // Load saved player names
    _savedPlayerNames = await Game.getSavedPlayerNames();
    
    // Check for a saved game
    _savedGame = await Game.loadCurrentGame();
    
    // Set the first player name in the text controller if available
    if (_savedPlayerNames.isNotEmpty) {
      _nameController.text = _savedPlayerNames[0];
    }
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetScoreController.dispose();
    super.dispose();
  }

  void _addPlayer() {
    if (_nameController.text.trim().isNotEmpty && _players.length < 6) {
      setState(() {
        _players.add(Player(name: _nameController.text.trim()));
        _nameController.clear();
      });
    } else if (_players.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can add up to 6 players only')),
      );
    }
  }

  void _removePlayer(int index) {
    if (_players.length > 2) {
      setState(() {
        _players.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You need at least 2 players to play')),
      );
    }
  }

  void _startGame() async {
    if (_players.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You need at least 2 players to play')),
      );
      return;
    }

    final targetScore = int.tryParse(_targetScoreController.text) ?? 100;
    final game = Game(players: _players, targetScore: targetScore);
    
    // Save player names for future use
    await game.savePlayerNames();
    
    // Save initial game state
    await game.saveCurrentGame();
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GameScreen(game: game),
      ),
    );
  }

  void _continueGame() {
    if (_savedGame != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GameScreen(game: _savedGame!),
        ),
      );
    }
  }

  void _viewHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }
  
  void _managePlayersScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PlayerManagementScreen(),
      ),
    );
    
    // Refresh data when returning from player management
    _loadSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gin Rummy Scorekeeper'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: _managePlayersScreen,
            tooltip: 'Manage Players',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _viewHistory,
            tooltip: 'Game History',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Saved game card (only show if a saved game exists)
                  if (_savedGame != null) ...[
                    Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Continue Saved Game',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Round: ${_savedGame!.currentRound} | Target: ${_savedGame!.targetScore}',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Players: ${_savedGame!.players.map((p) => p.name).join(", ")}',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _continueGame,
                              child: const Text('Continue Game'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'New Game',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                  ],
                  
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Game Setup',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _savedPlayerNames.isNotEmpty
                                    ? DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          labelText: 'Select Player',
                                          border: OutlineInputBorder(),
                                        ),
                                        value: _savedPlayerNames.isNotEmpty ? _savedPlayerNames[0] : null,
                                        items: _savedPlayerNames.map((name) {
                                          return DropdownMenuItem(
                                            value: name,
                                            child: Text(name),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              _nameController.text = value;
                                            });
                                          }
                                        },
                                      )
                                    : TextField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Player Name',
                                          border: OutlineInputBorder(),
                                        ),
                                        onSubmitted: (_) => _addPlayer(),
                                      ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: _addPlayer,
                                child: const Text('Add'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _targetScoreController,
                            decoration: const InputDecoration(
                              labelText: 'Target Score',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Players',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: _players.isEmpty
                        ? const Center(child: Text('No players added yet'))
                        : ListView.builder(
                            itemCount: _players.length,
                            itemBuilder: (context, index) {
                              final player = _players[index];
                              return ListTile(
                                title: Text(player.name),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _removePlayer(index),
                                ),
                              );
                            },
                          ),
                  ),
                  ElevatedButton(
                    onPressed: _players.length >= 2 ? _startGame : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Start New Game', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
    );
  }
}
