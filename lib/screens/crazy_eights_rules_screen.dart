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
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
              child: Row(
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'COMPLETE OFFICIAL RULES',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
            ),
            ExpansionTile(
              title: Text('The Deal & Setup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Players: 2–8. Use a standard 52-card deck.\n\n'
                    'Deal cards: 7 cards each for 2 players; 5 cards each for 3 or more '
                    'players. Place the remaining cards face-down as the stock pile. '
                    'Turn the top card face-up to start the discard pile.\n\n'
                    'If the first face-up card is an 8, return it to the middle of the '
                    'stock pile and turn a new card.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Play Mechanics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'On your turn, play one card from your hand that matches the top discard '
                    'by rank OR by suit. Eights are wild — an 8 may be played on any card, '
                    'and the player names the suit that the next player must match.\n\n'
                    'If you cannot play, draw cards from the stock one at a time until you '
                    'draw a playable card or the stock runs out. If the stock is empty and '
                    'you cannot play, your turn passes.\n\n'
                    'Play passes to the left. First player to empty their hand wins the round.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Special Cards (Popular Variants)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Standard Crazy Eights only designates 8s as wild. However many players '
                    'add house rules inspired by Uno-style games:\n\n'
                    '• Queen: Skips the next player\'s turn\n'
                    '• Ace: Reverses direction of play\n'
                    '• 2: Next player must draw 2 cards and skip their turn\n\n'
                    'These special card rules are NOT part of the standard rules and vary '
                    'widely. Agree on them before playing.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Scoring', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The winner of each hand scores points equal to the cards left in all '
                    'opponents\' hands:\n\n'
                    '• 8 = 50 points\n'
                    '• King, Queen, Jack, 10 = 10 points each\n'
                    '• Ace = 1 point\n'
                    '• Number cards 2–9 = face value\n\n'
                    'Keep a cumulative score. First player to reach the target (commonly 100) wins.',
                    style: TextStyle(fontSize: 15, height: 1.5),
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
