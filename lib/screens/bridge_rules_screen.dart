import 'package:flutter/material.dart';

class BridgeRulesScreen extends StatelessWidget {
  const BridgeRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Bridge'),
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
                    'Play in partnerships (2 vs 2). During bidding, one partnership contracts to '
                    'win a certain number of tricks. During play, each side tries to fulfill (or '
                    'defeat) that contract. Rubber Bridge is won by the first team to win 2 games; '
                    'a game is won by scoring 100+ points below the line.',
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
                    'Use a standard 52-card deck. 4 players sit in 2 partnerships (North-South '
                    'vs East-West). Deal all 52 cards (13 per player). Suits rank: '
                    'Spades (highest), Hearts, Diamonds, Clubs (lowest). No-trump is above all '
                    'suits for bidding purposes.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Bidding (The Auction)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.gavel),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Starting with the dealer, players take turns bidding, passing, doubling, or '
                    'redoubling. A bid names a number (1–7) and a trump suit (or No Trump). The '
                    'number represents tricks contracted beyond the book of 6 (so a bid of 1 means '
                    '7 tricks total, 7 means all 13).\n\n'
                    'The auction ends after three consecutive passes. The final bid is the '
                    'contract. The first player of the winning partnership to name the contract '
                    'suit becomes the declarer. The declarer\'s partner becomes the dummy.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Play', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.swap_horiz),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The player to the left of the declarer leads to the first trick. The dummy '
                    'then lays all their cards face-up on the table, organized by suit. The '
                    'declarer plays both their own hand and the dummy\'s hand.\n\n'
                    'Players must follow suit if able. Highest card of the led suit wins the '
                    'trick unless a trump is played, in which case the highest trump wins. '
                    'Winner of each trick leads the next.',
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
                        'Contract made (below the line — counts toward game):\n'
                        '• Clubs/Diamonds: 20 pts per trick bid\n'
                        '• Hearts/Spades: 30 pts per trick bid\n'
                        '• No Trump: 40 for first trick, 30 for each after\n\n'
                        'Overtricks (above the line — bonus only):\n'
                        '• Not vulnerable: 20/30 pts per overtrick\n'
                        '• Vulnerable: 20/30 pts per overtrick\n\n'
                        'Undertricks (penalties, above the line for defenders):\n'
                        '• Not vulnerable: 50 pts each\n'
                        '• Vulnerable: 100 pts each\n\n'
                        'Slam bonuses:\n'
                        '• Small slam (12 tricks): 500 (NV) / 750 (V)\n'
                        '• Grand slam (13 tricks): 1000 (NV) / 1500 (V)\n\n'
                        'Rubber bonus (winning 2 games first): 700 (2-0) or 500 (2-1)',
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
                    'Enter each team\'s total score after each hand (include all above-the-line '
                    'and below-the-line points combined). Track vulnerability and game progress '
                    'separately on paper or a scoring pad.',
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
              title: Text('Setup & The Auction', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Players: 4 in 2 fixed partnerships (North-South vs East-West). Use a '
                    'standard 52-card deck. Deal 13 cards to each player.\n\n'
                    'The auction: starting with the dealer, each player bids, passes, doubles '
                    'an opponent\'s bid, or redoubles their own doubled bid. A bid is a '
                    'number (1–7) plus a suit (Clubs, Diamonds, Hearts, Spades) or No Trump. '
                    'The number represents tricks contracted ABOVE 6 (bid of 3 Hearts '
                    'means your team must win 9 tricks with Hearts as trump).\n\n'
                    'Three consecutive passes end the auction. The player who first named '
                    'the final contract\'s suit/NT becomes the "declarer"; their partner '
                    'is the "dummy."',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Declarer Play', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The player to the left of the declarer leads the first card. After the '
                    'lead, dummy lays all their cards face-up on the table. The declarer '
                    'plays both their own hand and dummy\'s hand.\n\n'
                    'Standard trick-taking rules: players must follow suit if possible. If '
                    'you cannot follow suit, you may play any card (including trump). The '
                    'highest card of the led suit wins the trick unless a trump is played, '
                    'in which case the highest trump wins.\n\n'
                    'In a No Trump (NT) contract, there is no trump suit.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Scoring: Making Your Contract', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Trick scores (go BELOW the line toward game):\n'
                    '• Clubs or Diamonds: 20 pts per trick bid and made\n'
                    '• Hearts or Spades: 30 pts per trick bid and made\n'
                    '• No Trump: 40 pts for first trick, 30 pts for each additional\n\n'
                    'A "game" requires 100+ pts below the line in a single hand or '
                    'accumulated across multiple hands. Win 2 games to win the "rubber."\n\n'
                    'Rubber bonus: 700 pts for winning 2-0; 500 pts for winning 2-1.\n\n'
                    'Overtricks and slam bonuses go ABOVE the line (do not count toward game):\n'
                    '• Small slam (12 tricks): 500 pts non-vul; 750 pts vulnerable\n'
                    '• Grand slam (13 tricks): 1,000 pts non-vul; 1,500 pts vulnerable',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Scoring: Undertricks & Vulnerability', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'A side is "vulnerable" after winning their first game of the rubber. '
                    'Vulnerability increases both bonuses and penalties.\n\n'
                    'Undertricks (declarer fails contract) scored by defenders ABOVE the line:\n'
                    'Not doubled: 50/trick non-vul; 100/trick vul\n'
                    'Doubled: 100 / 200 / 200... per trick non-vul; '
                    '200 / 300 / 300... per trick vul\n\n'
                    'Doubled contracts that are made: bonus of 50 pts ("insult") plus '
                    'double the normal trick score. Redoubled = 4× trick score.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Hand Evaluation (HCP)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'High Card Points (HCP) are used to evaluate hand strength:\n'
                    '• Ace = 4 HCP, King = 3 HCP, Queen = 2 HCP, Jack = 1 HCP\n'
                    '• Total in deck = 40 HCP\n\n'
                    'Standard opening bid guidelines:\n'
                    '• 12–14 HCP: Open 1 of a suit\n'
                    '• ≈26 combined HCP needed for game in a major suit or NT\n'
                    '• ≈33 combined HCP needed for a small slam\n'
                    '• ≈37 combined HCP needed for a grand slam\n\n'
                    'Distribution points (shortness in a suit) may supplement HCP in '
                    'suit contracts.',
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
