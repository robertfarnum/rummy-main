import 'package:flutter/material.dart';

class CrazyEightsRulesScreen extends StatelessWidget {
  const CrazyEightsRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Crazy Eights'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              title: Text('Objective', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.flag),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Be the first to get rid of all your cards. Score points from the cards '
                    'remaining in your opponents\' hands. First player to reach the target score wins.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Setup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.style),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Use a standard 52-card deck with 2–7 players. Deal 5 cards to each player '
                    '(some variants use 7 cards). Place the remaining cards face down as the stock '
                    'pile. Turn the top card face up to start the discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Gameplay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.swap_horiz),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'On your turn, play a card that matches the top discard by suit or rank. '
                    'Eights are wild — you can play an 8 at any time and declare the new suit.\n\n'
                    'If you cannot play, draw cards from the stock pile until you find a playable '
                    'card. If the stock is empty, pass your turn.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Scoring', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.scoreboard),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'When a player goes out (plays their last card), they score points based on '
                        'the cards remaining in all opponents\' hands:',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Eights = 50 points each\n'
                        '• Face cards (King, Queen, Jack) = 10 points each\n'
                        '• Aces = 1 point each\n'
                        '• Number cards (2–7, 9–10) = face value',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The first player to reach the target score (default 100) wins the game.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
