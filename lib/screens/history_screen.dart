import 'package:flutter/material.dart';
import '../models/game.dart';
import '../models/player.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Game> _gameHistory = [];
  bool _isLoading = true;
  bool _isExporting = false;
  // Track expanded state of each game card
  final Map<int, bool> _expandedGames = {};

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
  
  Future<void> _exportGameHistory() async {
    try {
      // Show loading indicator
      setState(() {
        _isExporting = true;
      });
      
      // Get JSON data
      final jsonData = await Game.exportGameHistory();
      
      // Get temporary directory path
      final directory = await getTemporaryDirectory();
      final now = DateTime.now();
      final gameCount = _gameHistory.length;
      final fileName = 'rummy_history_${gameCount}_games_${DateFormat('yyyyMMdd_HHmmss').format(now)}.json';
      final filePath = '${directory.path}/$fileName';
      
      // Write JSON to file
      final file = File(filePath);
      await file.writeAsString(jsonData);
      
      // Hide loading indicator
      setState(() {
        _isExporting = false;
      });
      
      // Share the file
      await Share.shareXFiles(
        [XFile(filePath)],
        text: 'Rummy Scorekeeper Game History (${gameCount} games)',
        subject: 'Rummy Game History Export',
      );
      
      // Show success dialog
      _showExportSummary(gameCount, fileName);
      
    } catch (e) {
      setState(() {
        _isExporting = false;
      });
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error exporting game history: $e')),
      );
    }
  }

  // Show export summary dialog
  void _showExportSummary(int gameCount, String fileName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Exported $gameCount ${gameCount == 1 ? "game" : "games"} to:'),
            const SizedBox(height: 8),
            Text(
              fileName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('You can now share this file or save it as a backup.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _importGameHistory() async {
    try {
      // Show loading indicator
      setState(() {
        _isExporting = true;
      });
      
      // Open file picker
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
      );
      
      if (result != null && result.files.isNotEmpty) {
        final filePath = result.files.single.path;
        
        // Skip if no path (web platform) or empty path
        if (filePath == null || filePath.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not access the file path')),
          );
          setState(() {
            _isExporting = false;
          });
          return;
        }
        
        // Read the file content
        final file = File(filePath);
        final jsonData = await file.readAsString();
        
        // Validate the JSON format
        if (!Game.isValidGameHistoryJson(jsonData)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid game history file format')),
          );
          setState(() {
            _isExporting = false;
          });
          return;
        }
        
        // Import the data
        final importCount = await Game.importGameHistory(jsonData);
        
        // Reload the game history
        await _loadGameHistory();
        
        // Show appropriate message based on import count
        if (importCount > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$importCount ${importCount == 1 ? "game" : "games"} imported successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No new games found to import')),
          );
        }
      }
      
      setState(() {
        _isExporting = false;
      });
    } catch (e) {
      setState(() {
        _isExporting = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing game history: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_isExporting)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.upload),
              onPressed: _importGameHistory,
              tooltip: 'Import Game History',
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _gameHistory.isEmpty ? null : _exportGameHistory,
              tooltip: 'Export Game History',
            ),
          ],
        ],
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
                    
                    // Initialize expanded state if not already set
                    _expandedGames.putIfAbsent(index, () => false);

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
                        child: Column(
                          children: [
                            Padding(
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
                                    // Calculate score type stats
                                    final scoreTypeCounts = _calculateScoreTypeCounts(player);
                                    final hasSpecialScores = scoreTypeCounts['knock']! > 0 || 
                                                           scoreTypeCounts['gin']! > 0;

                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(text: player.name),
                                                if (hasSpecialScores)
                                                  const TextSpan(
                                                    text: ' *',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Text('${player.score} points'),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  
                                  // Show expand button
                                  Center(
                                    child: TextButton.icon(
                                      icon: Icon(
                                        _expandedGames[index]!
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                      ),
                                      label: Text(
                                        _expandedGames[index]!
                                            ? 'Show Less'
                                            : 'Show Details',
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _expandedGames[index] = !_expandedGames[index]!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Expanded game details
                            if (_expandedGames[index]!)
                              Container(
                                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Detailed Scores:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    ...game.players.map((player) {
                                      final scoreTypeCounts = _calculateScoreTypeCounts(player);
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            player.name,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text('Regular: '),
                                                    Text('${scoreTypeCounts['regular']} rounds'),
                                                    const SizedBox(width: 8),
                                                    Text('(${_getScoreByType(player, 'regular')} pts)'),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Knock: ', style: TextStyle(color: Colors.blueAccent)),
                                                    Text('${scoreTypeCounts['knock']} rounds'),
                                                    const SizedBox(width: 8),
                                                    Text('(${_getScoreByType(player, 'knock')} pts)'),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Gin: ', style: TextStyle(color: Colors.greenAccent.shade700)),
                                                    Text('${scoreTypeCounts['gin']} rounds'),
                                                    const SizedBox(width: 8),
                                                    Text('(${_getScoreByType(player, 'gin')} pts)'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
  
  // Helper method to calculate score type counts
  Map<String, int> _calculateScoreTypeCounts(Player player) {
    final result = {
      'regular': 0,
      'knock': 0,
      'gin': 0,
    };
    
    for (int i = 0; i < player.scoreTypes.length; i++) {
      switch (player.scoreTypes[i]) {
        case 'regular':
          result['regular'] = result['regular']! + 1;
          break;
        case 'knock':
          result['knock'] = result['knock']! + 1;
          break;
        case 'gin':
          result['gin'] = result['gin']! + 1;
          break;
      }
    }
    
    return result;
  }
  
  // Helper method to calculate score by type
  int _getScoreByType(Player player, String scoreType) {
    int totalScore = 0;
    
    for (int i = 0; i < player.scoreTypes.length; i++) {
      if (player.scoreTypes[i] == scoreType) {
        totalScore += player.gameScores[i];
      }
    }
    
    return totalScore;
  }
}