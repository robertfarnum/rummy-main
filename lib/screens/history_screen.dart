import 'package:flutter/material.dart';
import '../models/game.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Game> _gameHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGameHistory();
  }

  Future<void> _loadGameHistory() async {
    setState(() {
      _isLoading = true;
    });

    final history = await Game.loadGameHistory();
    
    setState(() {
      _gameHistory = history;
      _isLoading = false;
    });
  }

  // Add a method to delete a game
  Future<void> _deleteGame(int index) async {
    // Show confirmation dialog
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Game'),
        content: const Text('Are you sure you want to delete this game from history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('DELETE'),
          ),
        ],
      ),
    ) ?? false;

    if (shouldDelete) {
      final success = await Game.deleteGameFromHistory(index);
      
      if (success) {
        // Reload the history after successful deletion
        _loadGameHistory();
        
        // Show a snackbar confirmation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Game deleted from history')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _gameHistory.isEmpty
              ? const Center(child: Text('No game history found'))
              : ListView.builder(
                  itemCount: _gameHistory.length,
                  itemBuilder: (context, index) {
                    final game = _gameHistory[index];
                    final winners = game.getWinners();
                    final dateFormat = DateFormat('MMM d, yyyy - h:mm a');
                    final startDate = game.startTime != null 
                        ? dateFormat.format(game.startTime!) 
                        : 'Unknown';
                    
                    return Dismissible(
                      key: Key('game-$index'),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        return await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Game'),
                            content: const Text('Are you sure you want to delete this game from history?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('DELETE'),
                              ),
                            ],
                          ),
                        ) ?? false;
                      },
                      onDismissed: (direction) {
                        _deleteGame(index);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Game on $startDate',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () => _deleteGame(index),
                                    tooltip: 'Delete Game',
                                  ),
                                ],
                              ),
                              Text(
                                'Rounds: ${game.currentRound}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Winner: ${winners.map((w) => w.name).join(", ")}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text('Players:'),
                              ...game.players.map((player) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(player.name),
                                      Text('${player.score} points'),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}