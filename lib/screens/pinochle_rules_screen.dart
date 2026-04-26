import 'package:flutter/material.dart';

class PinochleRulesScreen extends StatelessWidget {
  const PinochleRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Pinochle'),
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
                    'Play in partnerships (2 vs 2) and be the first team to reach 1500 points. '
                    'Score points through melding card combinations and winning tricks containing '
                    'valuable cards.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('The Deck', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.style),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Pinochle uses a 48-card double deck: two copies each of 9, 10, J, Q, K, A '
                    'in all four suits (no 2s–8s). Deal 12 cards to each of the 4 players. '
                    'The remaining 4 cards form the "widow" (set aside).\n\n'
                    'Card rank within a suit: A (high), 10, K, Q, J, 9 (low).',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Bidding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.gavel),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Starting with the player to the dealer\'s left, players bid the minimum '
                    'number of points their team will score (meld + trick points). Minimum bid '
                    'is typically 150. Bidding continues until three players pass; the highest '
                    'bidder wins. The winning bidder names the trump suit and picks up the widow.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Melding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.grid_view),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'After trump is named, all players lay down melds for points:\n\n'
                        'Runs (trump suit):\n'
                        '• A-10-K-Q-J of trump (flush/run) = 150 pts\n'
                        '• K-Q of trump (royal marriage) = 40 pts\n\n'
                        'Marriages:\n'
                        '• K-Q of any non-trump suit = 20 pts each\n\n'
                        'Pinochle:\n'
                        '• J♦ + Q♠ = 40 pts\n'
                        '• Two J♦ + two Q♠ = 300 pts (double pinochle)\n\n'
                        'Four of a kind:\n'
                        '• Four Aces (one per suit) = 100 pts\n'
                        '• Four Kings = 80 pts\n'
                        '• Four Queens = 60 pts\n'
                        '• Four Jacks = 40 pts\n\n'
                        'Nines:\n'
                        '• 9 of trump (dix, pronounced "deece") = 10 pts each',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Trick-Taking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.swap_horiz),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'After melding, players pick up their cards and play tricks. Players must '
                    'follow suit if able, and must beat the current winning card if possible. '
                    'If unable to follow suit, players must play trump if able.\n\n'
                    'Trick point values:\n'
                    '• Ace = 11 pts\n'
                    '• 10 = 10 pts\n'
                    '• King = 4 pts\n'
                    '• Queen = 3 pts\n'
                    '• Jack = 2 pts\n'
                    '• 9 = 0 pts\n'
                    '• Last trick = 10 pts bonus',
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
                    'The bidding team must score at least their bid (meld + trick points combined). '
                    'If they meet or exceed the bid, they score all their points. '
                    'If they fail to meet the bid, the bid amount is subtracted from their score.\n\n'
                    'The non-bidding team always scores their meld and trick points.\n\n'
                    'First team to reach 1500 points wins.',
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
                    'Enter each team\'s score after each hand (meld points + trick points, or '
                    'negative if bidding team failed). First team to reach 1500 wins.',
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
              title: Text('The 48-Card Deck', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Pinochle uses a special 48-card deck: two copies of the 9, 10, J, Q, K, '
                    'and A in each of the four suits (no 2s through 8s). Players: 4 in 2 '
                    'fixed partnerships (partners sit opposite).\n\n'
                    'Deal 12 cards to each player and set aside 4 cards face-down as the '
                    '"widow" (or "kitty").\n\n'
                    'Card rank within each suit (high to low): A, 10, K, Q, J, 9.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Bidding & The Widow', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Each player in turn bids the minimum total points (meld + trick points) '
                    'their team will score. Bidding starts at 150 and each bid must exceed '
                    'the previous. Players who don\'t want to bid pass.\n\n'
                    'The highest bidder wins the auction, picks up the 4-card widow, adds '
                    'it to their hand (now 16 cards), then discards any 4 cards face-down. '
                    'The bidder then names the trump suit.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Meld Values', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'All players meld simultaneously before trick-taking:\n\n'
                    '• Run (A-10-K-Q-J of trump): 150 pts\n'
                    '• Double Run (two runs in trump): 1,500 pts\n'
                    '• Royal Marriage (K-Q of trump): 40 pts\n'
                    '• Marriage (K-Q of non-trump suit): 20 pts each\n'
                    '• Aces Around (one A in each suit): 100 pts\n'
                    '• Kings Around (one K in each suit): 80 pts\n'
                    '• Queens Around (one Q in each suit): 60 pts\n'
                    '• Jacks Around (one J in each suit): 40 pts\n'
                    '• Pinochle (J♦ + Q♠): 40 pts\n'
                    '• Double Pinochle: 300 pts\n'
                    '• Dix (9 of trump): 10 pts\n\n'
                    'Double versions of Aces/Kings/Queens/Jacks Around score 10× single.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Trick-Taking Phase', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'After melding, pick up all meld cards into your hand. The bidder\'s '
                    'left-hand neighbor leads the first trick.\n\n'
                    'Strict rules: you must follow suit if possible AND you must try to win '
                    'the trick (play a higher card of the same suit if you can). If you '
                    'cannot follow suit, you must play trump. If you cannot follow suit or '
                    'trump, play any card.\n\n'
                    'Trick values: A = 11, 10 = 10, K = 4, Q = 3, J = 2, 9 = 0. '
                    'Last trick taken = 10 bonus points. Total possible trick points = 250.',
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
                    'After trick-taking, each team counts meld points + trick points.\n\n'
                    'Bidding team: If their total meets or exceeds their bid, they score '
                    'all their points. If they fall short ("set"), they subtract their bid '
                    'from their score (can go negative).\n\n'
                    'Non-bidding team: Always scores their meld + trick points (cannot be set).\n\n'
                    'First team to reach 1,500 points wins. If both teams reach 1,500 '
                    'in the same hand, the bidding team wins.',
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
