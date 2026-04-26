import 'package:flutter/material.dart';

class GermanWhistRulesScreen extends StatelessWidget {
  const GermanWhistRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play German Whist'),
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
                    'Win more tricks than your opponent in the second phase of the game. '
                    'German Whist is a two-player trick-taking game where the first half '
                    'is about building a strong hand, and the second half is about winning tricks.',
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
                    'Use a standard 52-card deck with 2 players. Deal 13 cards to each player. '
                    'Place the remaining 26 cards face down as the stock pile. Turn the top card '
                    'face up — its suit is the trump suit for the game. Cards rank Ace (high) '
                    'down to 2 (low).',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phase 1: Building Your Hand', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        'The non-dealer leads a card. The other player must follow suit if possible, '
                        'otherwise may play any card. The highest card of the led suit wins, unless '
                        'a trump is played. The winner takes the face-up stock card, the loser takes '
                        'the next face-down card. A new card is turned face up. This continues until '
                        'the stock is empty.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('Phase 2: Playing for Tricks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        'Once the stock is exhausted, players play out their remaining 13 cards. '
                        'The same trick-taking rules apply: follow suit if possible, trumps beat '
                        'non-trump cards. The winner of each trick leads the next.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
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
                    'Only tricks won during Phase 2 count toward the score. The player who wins '
                    'more of the 13 tricks in Phase 2 wins the round. The winner scores the '
                    'difference in tricks won (e.g., if you win 8 tricks to your opponent\'s 5, '
                    'you score 3 points).',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('In This App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.phone_android),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Enter the number of tricks won in Phase 2 for each player after each round. '
                    'The player with the higher total tricks across all rounds wins.',
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
