import 'package:flutter/material.dart';

class SpadesRulesScreen extends StatelessWidget {
  const SpadesRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Spades'),
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
                    'Play in partnerships (2 vs 2) and be the first team to reach 500 points. '
                    'Each round, teams bid the number of tricks they expect to win, then try to '
                    'make their bid exactly. Spades are always trump.',
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
                    'Use a standard 52-card deck with 4 players in 2 partnerships. Partners sit '
                    'across from each other. Deal all 52 cards (13 per player). Cards rank '
                    'Ace (high) down to 2 (low). Spades are always the trump suit.',
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
                    'Before play, each player bids the number of tricks they expect to win '
                    '(0–13). A bid of 0 is called "Nil" — a risky bid worth bonus points if '
                    'successful. Partners\' bids are combined into a team bid.',
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
                    'if possible. If unable to follow suit, they may play any card including a '
                    'spade. Spades cannot be led until the suit has been "broken" (a spade has '
                    'been played on a previous trick) unless spades are the only cards in hand.\n\n'
                    'The highest card of the led suit wins the trick, unless a spade is played, '
                    'in which case the highest spade wins.',
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
                        'If a team makes their bid: score 10 × bid points. Each trick won over '
                        'the bid is a "bag" worth 1 point. Collecting 10 bags deducts 100 points '
                        '(bag penalty).\n\n'
                        'If a team fails to make their bid: deduct 10 × bid points.\n\n'
                        'Nil bid success: +100 points. Nil bid failure: −100 points.\n\n'
                        'First team to reach 500 points wins.',
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
                    'Enter each team\'s score after each round. Track bags separately and apply '
                    'the −100 bag penalty manually when a team reaches 10 bags. '
                    'First team to 500 wins.',
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
              title: Text('Deck & Partners', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Players: 4 in 2 fixed partnerships (partners sit opposite each other). '
                    'Use a standard 52-card deck. Deal all 52 cards, 13 to each player.\n\n'
                    'Spades are always trump. Card rank within each suit (high to low): '
                    'A, K, Q, J, 10, 9, 8, 7, 6, 5, 4, 3, 2.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Bidding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Each player bids the number of tricks they expect to win (0–13). Bids '
                    'are not secret — partners may consult strategy openly, though discussing '
                    'specific cards is against the rules. A team\'s bid is the sum of both '
                    'partners\' bids.\n\n'
                    'Nil: A player may bid Nil (0). If successful, their team earns +100 '
                    'bonus points. If they win even one trick, the penalty is −100. '
                    'Their partner\'s bid still stands independently.\n\n'
                    'Blind Nil: Some games allow bidding Nil before looking at cards: '
                    '\u00b1200 points.',
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
                    'The player holding the 2♣ leads the first trick. Players must follow '
                    'suit if possible. If you cannot follow suit, you may play any card '
                    'including a spade.\n\n'
                    'Spades cannot be led until the suit has been "broken" (a spade has been '
                    'played on a non-spade trick). Exception: a player may lead spades if '
                    'they have no other suits.\n\n'
                    'The highest card of the led suit wins the trick UNLESS a spade is '
                    'played, in which case the highest spade wins.',
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
                    'Making the bid: 10 \u00d7 bid points, plus 1 point per overtrick ("bag").\n'
                    'Failing the bid: \u221210 \u00d7 bid points.\n\n'
                    'Bags: Each overtrick counts as a bag. Every 10 bags accumulated '
                    'costs a team 100 points (bags reset to 0).\n\n'
                    'Nil success: +100 points. Nil failure: \u2212100 points.\n\n'
                    'First team to reach 500 points wins. If both teams reach 500 in '
                    'the same round, the team with the higher total wins.',
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
