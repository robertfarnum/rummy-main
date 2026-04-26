import 'package:flutter/material.dart';

class RummyRulesScreen extends StatelessWidget {
  const RummyRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Rummy'),
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
                    'Be the first player to empty your hand by forming all your cards into valid '
                    'sets and runs. Score points from the cards remaining in opponents\' hands. '
                    'First to reach the target score wins.',
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
                    'Use a standard 52-card deck with 2–6 players. Deal cards as follows:\n'
                    '• 2 players: 10 cards each\n'
                    '• 3–4 players: 7 cards each\n'
                    '• 5–6 players: 6 cards each\n\n'
                    'Place the remaining cards face down as the stock pile. Turn the top card '
                    'face up to start the discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Melds', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.grid_view),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Valid melds are:\n'
                    '• Set (Group): 3 or 4 cards of the same rank (e.g., 7♠ 7♥ 7♦)\n'
                    '• Run (Sequence): 3 or more consecutive cards of the same suit '
                    '(e.g., 4♣ 5♣ 6♣)\n\n'
                    'Aces can be high or low but not both (A-2-3 or Q-K-A, not K-A-2).',
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
                    'On your turn:\n'
                    '1. Draw one card from the stock pile or discard pile.\n'
                    '2. Optionally lay down melds or add cards to existing melds on the table.\n'
                    '3. Discard one card face-up onto the discard pile.\n\n'
                    'Going Out: When a player has melded all their cards (with one discard), '
                    'the round ends. Players may also "go rummy" by laying all cards at once '
                    'without any previous melds — this doubles the hand score.',
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
                        'The player who goes out scores points for all cards remaining in '
                        'opponents\' hands:\n'
                        '• Aces = 1 point\n'
                        '• Number cards = face value\n'
                        '• Face cards (J, Q, K) = 10 points each\n\n'
                        'If a player goes rummy, the score is doubled. '
                        'First player to reach 100 points wins.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
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
                    'Enter each player\'s round score after each hand. First player to reach '
                    'the target score (default 100) wins.',
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
              title: Text('The Deck & Deal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Players: 2–6. Use a standard 52-card deck. Deal cards:\n'
                    '• 2 players: 10 cards each\n'
                    '• 3–4 players: 7 cards each\n'
                    '• 5–6 players: 6 cards each\n\n'
                    'Place the remaining cards face-down as the stock pile. Turn the top '
                    'card face-up beside it to start the discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Melds', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'A meld is a valid grouping of 3 or more cards:\n\n'
                    '• Set (Group): 3 or 4 cards of the same rank (e.g., three 7s)\n'
                    '• Run (Sequence): 3 or more consecutive cards of the same suit '
                    '(e.g., 4–5–6 of Hearts)\n\n'
                    'In Standard Rummy, Aces are low only (A-2-3 is valid; Q-K-A is not).',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Turn Sequence', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    '1. DRAW: Take the top card from either the stock pile or the discard pile.\n\n'
                    '2. MELD (optional): Place one or more valid melds face-up on the table. '
                    'You may also "lay off" cards onto existing melds (yours or opponents\').\n\n'
                    '3. DISCARD: Place one card face-up on the discard pile. You may NOT '
                    'discard the card you just picked up from the discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Going Out & Scoring', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Go out by melding all remaining cards in your hand (with a final discard, '
                    'or by laying off the last card). When someone goes out, the round ends.\n\n'
                    'Going Rummy: If you meld ALL your cards in one turn with no previous '
                    'melds that hand, the score for the whole round is doubled.\n\n'
                    'Scoring: The winner scores points equal to the combined value of '
                    'cards still held in all opponents\' hands:\n'
                    '• Face cards (J, Q, K) = 10 points each\n'
                    '• Ace = 1 point\n'
                    '• Number cards = face value\n\n'
                    'First player to reach the target (commonly 100 points) wins.',
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
