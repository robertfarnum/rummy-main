import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Gin Rummy'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // Objective
            ExpansionTile(
              title: Text('Objective', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.flag),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The goal of Gin Rummy is to form your hand into combinations of sets and runs '
                    '(called "melds") while minimizing the point value of unmatched cards (called '
                    '"deadwood"). Score points by ending rounds through knocking or going gin. '
                    'The first player to reach 100 points wins the game.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),

            // Setup
            ExpansionTile(
              title: Text('Setup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.style),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Deck', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        'Gin Rummy uses a standard 52-card deck (no jokers). The game is played between 2 players.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('Card Values', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        '• Face cards (King, Queen, Jack) = 10 points each\n'
                        '• Aces = 1 point\n'
                        '• Number cards (2–10) = face value',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('Dealing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        'Each player is dealt 10 cards. The remaining cards form the stock pile (face down). '
                        'The top card of the stock pile is turned face up to start the discard pile.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('Opening Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        'The non-dealer gets the first choice: they may pick up the face-up card or pass. '
                        'If they pass, the dealer may take it. If both players pass on the face-up card, '
                        'the non-dealer draws from the stock pile and play continues normally.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Gameplay
            ExpansionTile(
              title: Text('Gameplay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.swap_horiz),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Players alternate turns. On each turn, a player must:',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '1. Draw one card — either the top card from the stock pile (face down) '
                        'or the top card from the discard pile (face up).',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '2. Discard one card — place one card from your hand face up on the discard pile.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The goal on each turn is to improve your hand by forming melds and reducing deadwood.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Melds
            ExpansionTile(
              title: Text('Melds', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.collections),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Melds are combinations of cards. There are two types:',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('Sets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        '3 or 4 cards of the same rank.\n'
                        'Example: 7♠ 7♥ 7♦ or K♣ K♠ K♥ K♦',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('Runs', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        '3 or more consecutive cards of the same suit.\n'
                        'Example: 4♥ 5♥ 6♥ or 9♠ 10♠ J♠ Q♠',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Cards that are not part of any meld are called "deadwood". '
                        'The point value of your deadwood determines when you can knock.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Knocking & Gin
            ExpansionTile(
              title: Text('Knocking & Gin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.back_hand),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Knocking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
                      SizedBox(height: 4),
                      Text(
                        'When your deadwood totals 10 points or fewer, you may end the round by "knocking". '
                        'Lay down your melds and deadwood. Your opponent then lays off any cards that can extend '
                        'your melds, and reveals their own deadwood.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'The knocker scores the difference between the two players\' deadwood values. '
                        'However, if the opponent\'s deadwood is equal to or less than the knocker\'s, '
                        'the opponent "undercuts" and receives a bonus (typically 25 points) plus the difference.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('Gin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                      SizedBox(height: 4),
                      Text(
                        'If you have no deadwood at all (every card is part of a meld), you "go gin". '
                        'Your opponent cannot lay off cards on your melds. You receive a 25-point bonus '
                        'plus the total value of your opponent\'s deadwood.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Scoring
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
                        '• Knock: The knocker scores the difference between the players\' deadwood values.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '• Gin bonus: 25 points, plus the opponent\'s total deadwood value.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '• Undercut bonus: If the opponent\'s deadwood is equal to or less than the knocker\'s, '
                        'the opponent scores 25 points plus the deadwood difference.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Rounds continue until a player reaches the target score (default 100 points). '
                        'That player wins the game.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('In This App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        'When entering scores, select "Gin" to automatically add the 25-point bonus. '
                        'Select "Knock" for regular knock scoring. The app tracks cumulative scores '
                        'across rounds and determines the winner when the target score is reached.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
