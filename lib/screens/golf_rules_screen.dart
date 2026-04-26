import 'package:flutter/material.dart';

class GolfRulesScreen extends StatelessWidget {
  const GolfRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Golf'),
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
                    'Have the lowest total score after 9 rounds (holes). Like the sport, lower is '
                    'better in Golf the card game.',
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
                    'Use a standard 52-card deck (use two decks for 5+ players). Deal 6 cards to '
                    'each player, arranged in a 2×3 grid face down. Each player turns 2 cards face '
                    'up. Place the remaining cards as a stock pile with the top card face up as the '
                    'discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Card Values', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.looks_one),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    '• King = 0 points\n'
                    '• Queen, Jack = 10 points each\n'
                    '• Aces = 1 point\n'
                    '• Number cards (2–10) = face value\n'
                    '• Matching column: Two cards of the same rank in a column cancel out (0 points)',
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
                    'On your turn, draw from the stock or discard pile. Replace one of your 6 cards '
                    '(face up or face down) with the drawn card, discarding the replaced card. Or '
                    'discard the drawn card and flip one of your face-down cards face up. The round '
                    'ends when one player has all 6 cards face up — each other player gets one more turn.',
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
                  child: Text(
                    'After each round, all cards are turned face up and scored. Add up the point '
                    'values of your cards, remembering that matching columns cancel out. Play 9 '
                    'rounds total. The player with the lowest cumulative score wins.',
                    style: TextStyle(fontSize: 15, height: 1.5),
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
              title: Text('Setup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Players: 2–5 (use 2 decks for 6+). Use a standard 52-card deck.\n\n'
                    'Deal 6 cards to each player, arranged face-down in a 2×3 grid. Each '
                    'player turns any 2 of their cards face-up. Place the remaining deck '
                    'face-down as the stock pile. Turn the top card face-up to start the '
                    'discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Card Values', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    '• 2 = −2 points (a bonus card)\n'
                    '• Ace = 1 point\n'
                    '• Number cards 3–10 = face value\n'
                    '• Jack and Queen = 10 points each\n'
                    '• King = 0 points\n\n'
                    'Special rule: Two cards of the same rank in the same column cancel '
                    'each other out and score 0 points combined (even if one is face-down).',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('A Turn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'On your turn, choose one of two actions:\n\n'
                    '1. Take a card (from stock or discard): Replace one of your 6 grid cards '
                    'with it. The replaced card goes face-up onto the discard pile. The card '
                    'you place may be face-up or face-down.\n\n'
                    '2. Decline the discard pile: Draw the top card from the stock. If you '
                    'want it, replace one grid card as above. If not, discard it and '
                    'flip one of your face-down grid cards face-up.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('End of Round & Scoring', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'When a player turns their last card face-up, all other players each '
                    'take one final turn. Then all remaining face-down cards are turned face-up.\n\n'
                    'Each player totals their 6 cards. Matching same-rank pairs in a column '
                    'score 0. All other cards score their point values.\n\n'
                    'Play 9 rounds ("holes"). Like in the sport of golf, the player with the '
                    'LOWEST total score after 9 rounds wins.',
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
