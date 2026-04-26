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
              title: Text('Deck, Trump & Setup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Players: 2. Use a standard 52-card deck. Deal 13 cards to each player. '
                    'Place the remaining 26 cards face-down as the stock pile.\n\n'
                    'Turn the top card of the stock face-up. Its suit is trump for the '
                    'entire game. Card rank within each suit (high to low): A, K, Q, J, 10, '
                    '9, 8, 7, 6, 5, 4, 3, 2.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Phase 1: Building Your Hand', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The non-dealer leads the first trick. Standard trick-taking rules apply: '
                    'follow suit if possible; otherwise play any card. Trump beats non-trump; '
                    'highest card of led suit wins if no trump is played.\n\n'
                    'After each trick, BEFORE leading the next:\n'
                    '• Winner takes the FACE-UP card on top of the stock\n'
                    '• Loser takes the next card from the stock (face-down, unseen)\n'
                    '• A new card from the stock is turned face-up for the next trick\n\n'
                    'Phase 1 ends after 13 tricks, when the stock is exhausted.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Phase 2: The Decisive 13 Tricks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Once the stock is empty, play the remaining 13 trick-taking rounds with '
                    'the hand you have built. The same rules apply: follow suit if possible; '
                    'trump beats non-trump; highest card of led suit wins.\n\n'
                    'No new cards are drawn in Phase 2. The winner of each trick leads next.',
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
                    'ONLY tricks won in Phase 2 count toward the score. Phase 1 is purely '
                    'hand-building.\n\n'
                    'Count your Phase 2 tricks. The player who won more of the 13 Phase 2 '
                    'tricks wins the game. Common scoring methods:\n'
                    '• 1 point per game won (match play)\n'
                    '• Score = difference in Phase 2 tricks (e.g., winning 8–5 scores 3 points)',
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
