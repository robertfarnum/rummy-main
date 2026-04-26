import 'package:flutter/material.dart';

class HeartsRulesScreen extends StatelessWidget {
  const HeartsRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Hearts'),
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
                    'Avoid taking tricks containing hearts or the Queen of Spades. '
                    'Hearts are worth 1 point each and the Queen of Spades is worth 13 points. '
                    'The player with the lowest score when any player reaches 100 points wins.',
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
                    'Use a standard 52-card deck with 3–6 players. For 4 players, deal all 52 '
                    'cards (13 each). For other counts, remove low cards to make the deal even. '
                    'Cards rank Ace (high) down to 2 (low). There is no trump suit.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Passing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.swap_horiz),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Before each round, each player passes 3 cards face-down to another player. '
                    'The direction rotates: left, right, across, then no pass (hold), repeating each '
                    'four rounds.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Gameplay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.games),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The player holding the 2 of Clubs leads it to start. Players must follow '
                    'suit if able. If unable, they may play any card. Hearts cannot be led until '
                    'hearts have been "broken" (a heart discarded on a previous trick) unless '
                    'the player has only hearts.\n\n'
                    'The highest card of the led suit wins the trick. No trump suit.',
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
                        '• Each heart taken = 1 point\n'
                        '• Queen of Spades = 13 points\n\n'
                        'Shooting the Moon: If one player takes ALL 13 hearts AND the Queen '
                        'of Spades in a round, that player scores 0 and all other players '
                        'score 26 points (or the shooter may choose to deduct 26 from their '
                        'own score).\n\n'
                        'The game ends when any player reaches 100 points. The player with the '
                        'lowest score wins.',
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
                    'Enter each player\'s penalty points after each round. The game ends when '
                    'any player reaches 100. The player with the lowest total wins.',
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
              title: Text('The Deal & Passing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Players: 4. Use a standard 52-card deck. Deal 13 cards to each player.\n\n'
                    'Before play, each player selects 3 cards from their hand and passes them '
                    'simultaneously to a neighbor. The passing direction rotates each round:\n'
                    '1st round: pass left\n'
                    '2nd round: pass right\n'
                    '3rd round: pass across\n'
                    '4th round: no passing ("hold")\n'
                    'This 4-round cycle repeats throughout the game.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('The Play', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The player holding 2♣ leads it to start the first trick. Players must '
                    'follow suit if possible. There is no trump suit.\n\n'
                    'Hearts may not be led until the suit is "broken" (a heart has been '
                    'played as a discard on a trick). Exception: a player may lead hearts if '
                    'they have no other suits remaining.\n\n'
                    'The Queen of Spades may be played at any time as a discard. '
                    'No point cards (hearts or Q♠) may be played on the first trick.\n\n'
                    'The highest card of the led suit wins each trick. The trick winner '
                    'leads the next trick.',
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
                    'After each round, players count penalty points in tricks they won:\n\n'
                    '• Each heart = 1 penalty point\n'
                    '• Queen of Spades (Q♠) = 13 penalty points\n'
                    '• All other cards = 0 points\n\n'
                    'The game ends when any player reaches 100 points. '
                    'The player with the LOWEST total score wins.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Shooting the Moon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'If one player wins ALL 13 hearts AND the Queen of Spades in a single '
                    'round, they have "shot the moon." Instead of receiving 26 penalty '
                    'points, the shooter takes 0 points for that round and all other players '
                    'receive 26 points each.\n\n'
                    'Some rule sets offer a choice: either add 26 to everyone else, or '
                    'subtract 26 from your own total. Agree on this before playing.',
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
