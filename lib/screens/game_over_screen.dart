import 'package:flutter/material.dart';
import '../models/game.dart';
import '../models/player.dart';
import 'home_screen.dart';

class GameOverScreen extends StatelessWidget {
  final Game game;

  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final winners = game.getWinners();
    // Ensure the game is marked as finished and saved
    game.finishGame();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Game Results',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      winners.length == 1
                          ? '${winners[0].name} Wins!'
                          : 'Tie Game!',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Final Score: ${winners[0].score}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Rounds: ${game.currentRound}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Final Standings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _buildFinalStandings(),
            ),
            ElevatedButton(
              onPressed: () => _startNewGame(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Start New Game'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => _backToHome(context),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalStandings() {
    // Sort players by score (highest first)
    final sortedPlayers = List<Player>.from(game.players)
      ..sort((a, b) => b.score.compareTo(a.score));
    
    return ListView.builder(
      itemCount: sortedPlayers.length,
      itemBuilder: (context, index) {
        final player = sortedPlayers[index];
        final isWinner = game.getWinners().contains(player);
        
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: isWinner 
              ? Theme.of(context).colorScheme.secondaryContainer 
              : null,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            title: Text(
              player.name,
              style: TextStyle(
                fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: Text(
              '${player.score}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        );
      },
    );
  }

  void _startNewGame(BuildContext context) {
    game.resetGame();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void _backToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
      (route) => false,
    );
  }
}
