import 'package:flutter/material.dart';

class CanastaRulesScreen extends StatelessWidget {
  const CanastaRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Canasta'),
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
                    'Play in partnerships (2 vs 2) and be the first team to reach 5000 points. '
                    'Score points by melding cards and forming canastas (melds of 7 or more cards '
                    'of the same rank).',
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
                    'Use 2 standard 52-card decks plus 4 jokers (108 cards total). 4 players '
                    'play in 2 partnerships, partners sitting across from each other. Deal 11 '
                    'cards to each player. Place the remaining cards face down as the stock. '
                    'Turn one card face up to start the discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Wild Cards', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.star),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Jokers and 2s are wild cards. They can substitute for any natural card in '
                    'a meld. A meld may contain at most as many wild cards as natural cards, '
                    'and must have at least 2 natural cards.\n\n'
                    'Black 3s are semi-wild: they can only be melded as a set of three or four '
                    'black 3s (no wild cards), and only when going out.\n\n'
                    'Red 3s are bonus cards — lay them face-up when drawn (worth 100 pts each, '
                    'or 200 pts each if a team collects all four).',
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
                    '1. Draw two cards from the stock (or take the entire discard pile if '
                    'you can immediately meld the top card).\n'
                    '2. Meld cards: lay down sets of 3+ cards of the same rank.\n'
                    '3. Discard one card.\n\n'
                    'A team\'s first meld must meet a minimum point value based on their '
                    'current score:\n'
                    '• Score below 0: 15 pts minimum\n'
                    '• Score 0–1499: 50 pts minimum\n'
                    '• Score 1500–2999: 90 pts minimum\n'
                    '• Score 3000+: 120 pts minimum',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Canastas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.layers),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'A canasta is a meld of 7 or more cards of the same rank.\n\n'
                    '• Natural canasta (no wild cards): worth 500 pts — mark by squaring the pile.\n'
                    '• Mixed canasta (contains wild cards): worth 300 pts — mark with a wild card '
                    'on top.\n\n'
                    'A team must have at least one canasta to go out.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Going Out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.exit_to_app),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'A player may go out when their team has at least one canasta. They meld or '
                    'add all remaining cards to melds, with one final discard (optional).\n\n'
                    'You may ask your partner "May I go out?" before doing so; the partner must '
                    'answer honestly.\n\n'
                    'Going out bonus: 100 points. Going out concealed (all cards melded at once, '
                    'having made no previous melds): 200 points.',
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
                        'Card point values:\n'
                        '• Jokers = 50 pts each\n'
                        '• 2s and Aces = 20 pts each\n'
                        '• 8s–Kings = 10 pts each\n'
                        '• 4s–7s = 5 pts each\n'
                        '• Black 3s = 5 pts each\n\n'
                        'At the end of a round, each team scores:\n'
                        '+ Points for all melded cards\n'
                        '+ Canasta bonuses (500 natural, 300 mixed)\n'
                        '+ Red 3 bonuses\n'
                        '+ Going out bonus\n'
                        '− Points for all cards still in hand\n\n'
                        'First team to 5000 points wins.',
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
                    'Enter each team\'s total score after each round. First team to reach 5000 '
                    'points wins.',
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
              title: Text('The 108-Card Deck', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Canasta uses 2 standard 52-card decks plus 4 Jokers = 108 cards. '
                    'Players: 4 in 2 fixed partnerships (partners sit opposite). '
                    'Deal 11 cards to each player.\n\n'
                    'Wild cards: Jokers (50 pts each) and 2s (20 pts each). A meld may '
                    'contain a maximum of 3 wild cards.\n\n'
                    'Red 3s (3♥ or 3♦): When drawn or dealt, lay face-up immediately and '
                    'draw a replacement card. Each red 3 scores 100 bonus points for your team.\n\n'
                    'Black 3s (3♠ or 3♣): Stop cards — a discarded black 3 prevents the '
                    'next player from picking up the discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Initial Meld Requirements', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'A team\'s first meld each round must meet a minimum point value based '
                    'on the team\'s cumulative score at the start of that round:\n\n'
                    '• Score below 0: minimum first meld = 15 pts\n'
                    '• Score 0 to 1,499: minimum first meld = 50 pts\n'
                    '• Score 1,500 to 2,999: minimum first meld = 90 pts\n'
                    '• Score 3,000 or more: minimum first meld = 120 pts\n\n'
                    'The discard pile may NOT be used toward the initial meld requirement.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Turn Sequence & Discard Pile Pickup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'On your turn:\n\n'
                    '1. DRAW: Take 1 card from the stock OR take the entire discard pile.\n'
                    '   To take the discard pile: you must hold 2 natural (non-wild) cards '
                    '   matching the top card, and either your team has already melded or the '
                    '   pile pickup qualifies as your initial meld. A frozen pile '
                    '   (caused by a wild card discard or a black 3) requires 2 natural '
                    '   matching cards in hand regardless.\n\n'
                    '2. MELD (optional): Lay down or extend sets of 3+ same-rank cards. '
                    '   Max 3 wild cards per meld.\n\n'
                    '3. DISCARD: Place 1 card face-up on the discard pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Canastas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'A canasta is a completed meld of 7 cards. Two types:\n\n'
                    '• Natural (Pure) Canasta: 7 cards of the same rank, no wild cards. '
                    'Worth 500 points. Mark with a red card on top.\n\n'
                    '• Mixed Canasta: 7 cards including at least one wild card. '
                    'Worth 300 points. Mark with a wild card on top.\n\n'
                    'A team MUST have at least 1 completed canasta before going out.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Going Out & Round Scoring', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'To go out: meld all remaining cards (with or without a final discard), '
                    'having at least 1 canasta. You may ask your partner "May I go out?" '
                    'before your turn; they must answer yes or no.\n\n'
                    'Going out bonus: +100 points. Concealed hand (going out without '
                    'previous melds): +200 points.\n\n'
                    'Round scoring for each team:\n'
                    '+ Values of all melded cards\n'
                    '+ Canasta bonuses (500 each natural, 300 each mixed)\n'
                    '+ Red 3 bonuses (100 each; \u00d74 if team has all four red 3s)\n'
                    '+ Going out bonus\n'
                    '\u2212 Values of cards remaining in hand\n\n'
                    'First team to 5000 points wins.',
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
