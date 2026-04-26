import 'package:flutter/material.dart';

class EuchreRulesScreen extends StatelessWidget {
  const EuchreRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Euchre'),
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
                    'Play in partnerships (2 vs 2) and be the first team to reach 10 points. '
                    'Each round, the team that names trump must win at least 3 of 5 tricks '
                    'to score points.',
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
                    'Use a 24-card deck: remove all 2s–8s, keeping 9, 10, J, Q, K, A in each '
                    'suit. 4 players sit in 2 partnerships. Deal 5 cards to each player, with '
                    'one card turned face up to propose the trump suit.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Trump & Card Ranking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.military_tech),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The trump suit has a special ranking:\n'
                    '1. Right Bower: Jack of trump suit (highest)\n'
                    '2. Left Bower: Jack of the same-color suit\n'
                    '3. Ace of trump\n'
                    '4. King of trump\n'
                    '5. Queen of trump\n'
                    '6. 10 of trump\n'
                    '7. 9 of trump (lowest trump)\n\n'
                    'Non-trump suits rank: A, K, Q, J (if not left bower), 10, 9.',
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
                    'Round 1: Starting left of the dealer, each player may order up (accepting '
                    'the face-up card\'s suit as trump) or pass. If ordered up, the dealer picks '
                    'up the card and discards one. If all pass, the face-up card is turned down.\n\n'
                    'Round 2: Players may name any other suit as trump or pass. If all pass '
                    'again, the hand is redealt.',
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
                    'The player to the left of the dealer leads first. Players must follow suit '
                    'if able (the left bower counts as trump, not its original suit). Highest card '
                    'of the led suit wins, or highest trump if any trump is played. '
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
                        'Makers (team that named trump):\n'
                        '• Win 3–4 tricks: 1 point\n'
                        '• Win all 5 tricks (march): 2 points\n'
                        '• Win all 5 tricks alone (going alone): 4 points\n\n'
                        'Euchre (makers take fewer than 3 tricks): opposing team scores 2 points.\n\n'
                        'First team to 10 points wins.',
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
                    'Enter each team\'s points after each hand. First team to reach 10 points wins.',
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
              title: Text('The 24-Card Deck & Dealing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Remove all 2s through 8s from the deck, leaving 24 cards (9, 10, J, Q, K, A '
                    'in each suit). Players: 4 in 2 fixed partnerships (partners sit opposite).\n\n'
                    'Deal 5 cards to each player in batches (typically 2-3-2-3 or 3-2-3-2). '
                    'Place the remaining 4 cards face-down. Turn the top card of this kitty '
                    'face-up to propose trump.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Trump Selection', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Round 1: Starting with the player left of the dealer, each player may either '
                    '"order up" the face-up suit as trump or pass. If ordered up, the dealer '
                    'picks up the face-up card and discards one card face-down. The ordered suit '
                    'becomes trump. If all four players pass, the face-up card is turned down.\n\n'
                    'Round 2: Starting again to the dealer\'s left, each player may name any '
                    'DIFFERENT suit as trump or pass. The dealer must name a suit if the others '
                    'all passed ("stick the dealer" rule, common in North America). '
                    'If no suit is named, the cards are redealt.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('The Bower System of Trump', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Trump suit hierarchy (highest to lowest):\n'
                    '1. Right Bower — the Jack of the trump suit (highest trump)\n'
                    '2. Left Bower — the Jack of the other suit of the SAME COLOR (2nd highest)\n'
                    '3. Ace, King, Queen, 10, 9 of trump\n\n'
                    'Critical: The Left Bower is treated as a member of the trump suit, '
                    'NOT of its original suit. E.g., if Hearts are trump, the J♦ becomes '
                    'the Left Bower and counts as Hearts.\n\n'
                    'Going Alone: The player who ordered trump may declare "going alone." '
                    'Their partner discards their cards and sits out. Potential reward: 4 '
                    'points instead of 2 for a march.',
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
                    'Lead is made by the player left of the dealer. Must follow suit if '
                    'possible (the Left Bower counts as trump). Highest trump beats all; '
                    'otherwise highest card of led suit wins.\n\n'
                    'Scoring for the making team (the team that named trump):\n'
                    '• Win 3 or 4 tricks: 1 point\n'
                    '• March (win all 5 tricks): 2 points\n'
                    '• Going Alone: march = 4 points; 3–4 tricks = 1 point\n\n'
                    'Euchre (making team wins fewer than 3 tricks): Defending team gets '
                    '2 points.\n\n'
                    'First team to reach 10 points wins.',
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
