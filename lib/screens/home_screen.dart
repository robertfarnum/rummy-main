import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/game.dart';
import '../models/game_config.dart';
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
  List<Game> _savedGames = [];
  bool _isLoading = true;
  GameConfig _selectedGame = GameConfig.allGames.first;

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
    
    // Load all saved games
    _savedGames = await Game.loadAllSavedGames();
    
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
    if (_nameController.text.trim().isNotEmpty && _players.length < _selectedGame.maxPlayers) {
      setState(() {
        _players.add(Player(name: _nameController.text.trim()));
        _nameController.clear();
      });
    } else if (_players.length >= _selectedGame.maxPlayers) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_selectedGame.name} allows up to ${_selectedGame.maxPlayers} players')),
      );
    }
  }

  void _removePlayer(int index) {
    setState(() {
      _players.removeAt(index);
    });
  }

  void _startGame() async {
    if (_players.length < _selectedGame.minPlayers) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_selectedGame.name} requires at least ${_selectedGame.minPlayers} players')),
      );
      return;
    }

    final targetScore = _selectedGame.hasTargetScore
        ? (int.tryParse(_targetScoreController.text) ?? _selectedGame.defaultTargetScore ?? 100)
        : 0;
    final game = Game(players: _players, targetScore: targetScore, gameType: _selectedGame.id);
    
    // Save player names for future use
    await game.savePlayerNames();
    
    // Save initial game state
    await game.saveGame();
    
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GameScreen(game: game),
      ),
    ).then((_) => _loadSavedData());
  }

  void _continueGame(Game game) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GameScreen(game: game),
      ),
    ).then((_) => _loadSavedData());
  }

  void _deleteSavedGame(int index, String gameName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Game'),
        content: Text('Delete this $gameName game?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Game.deleteSavedGame(index);
              _loadSavedData();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _viewHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }
  
  void _managePlayersScreen() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PlayerManagementScreen(),
      ),
    );
    
    // Refresh data when returning from player management
    _loadSavedData();
  }

  void _openRulesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _selectedGame.rulesScreenBuilder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Game Scorekeeper'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _openRulesScreen,
            tooltip: 'How to Play',
          ),
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
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Saved games list (only show if saved games exist)
                        if (_savedGames.isNotEmpty) ...[
                          const Text(
                            'Saved Games',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...List.generate(_savedGames.length, (index) {
                            final game = _savedGames[index];
                            return Card(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            game.gameConfig.name,
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            game.gameConfig.hasTargetScore
                                                ? 'Round ${game.currentRound} | Target: ${game.targetScore}'
                                                : 'Round ${game.currentRound}',
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                          Text(
                                            game.players.map((p) => p.name).join(', '),
                                            style: Theme.of(context).textTheme.bodySmall,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () => _deleteSavedGame(game.saveIndex!, game.gameConfig.name),
                                      tooltip: 'Delete',
                                    ),
                                    ElevatedButton(
                                      onPressed: () => _continueGame(game),
                                      child: const Text('Continue'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
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
                                DropdownButtonFormField<GameConfig>(
                                  decoration: const InputDecoration(
                                    labelText: 'Select Game',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedGame,
                                  items: GameConfig.allGames.map((game) {
                                    return DropdownMenuItem(
                                      value: game,
                                      child: Text(game.name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedGame = value;
                                        if (value.hasTargetScore && value.defaultTargetScore != null) {
                                          _targetScoreController.text = value.defaultTargetScore.toString();
                                        }
                                      });
                                    }
                                  },
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
                                              initialValue: _savedPlayerNames.isNotEmpty ? _savedPlayerNames[0] : null,
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
                                if (_selectedGame.hasTargetScore)
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
                        if (_players.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(child: Text('No players added yet')),
                          )
                        else
                          ...List.generate(_players.length, (index) {
                            final player = _players[index];
                            return ListTile(
                              title: Text(player.name),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _removePlayer(index),
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (_savedGames.length >= Game.maxSavedGames)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Save limit reached (${Game.maxSavedGames}). Delete a game to start a new one.',
                            style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _players.length >= _selectedGame.minPlayers && _savedGames.length < Game.maxSavedGames
                              ? _startGame
                              : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Start New Game', style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
