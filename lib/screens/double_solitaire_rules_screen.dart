import 'package:flutter/material.dart';

class DoubleSolitaireRulesScreen extends StatelessWidget {
  const DoubleSolitaireRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Double Solitaire'),
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
                    'Play more cards to the shared foundation piles than your opponent. Double '
                    'Solitaire is a competitive two-player version of Klondike Solitaire.',
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
                    'Each player uses their own standard 52-card deck (different backs recommended). '
                    'Each player sets up a standard Klondike solitaire layout: 7 tableau columns '
                    '(1 card in the first, 2 in the second, etc., with the top card face up). '
                    'Remaining cards form each player\'s stock pile. The foundation area in the '
                    'center is shared between both players.',
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
                    'Both players play simultaneously on their own tableaus. Tableau rules follow '
                    'standard Klondike: build down in alternating colors. Foundation piles are '
                    'shared — either player can play Aces to start a foundation and build up by suit '
                    '(Ace through King). Players draw from their own stock piles (typically 3 cards '
                    'at a time). Speed matters — if both players want to play on the same foundation, '
                    'whoever plays first gets it.',
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
                    'When both players are stuck (no more moves), count the cards each player '
                    'played to the foundation piles (identified by card backs). The player with '
                    'more foundation cards wins the round. Enter each player\'s foundation card '
                    'count as their score.',
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
              title: Text('Setup (Each Player)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Each player uses their own standard 52-card deck — use decks with '
                    'different back designs to tell them apart.\n\n'
                    'Each player independently sets up a standard Klondike Solitaire tableau: '
                    '7 columns with 1, 2, 3, 4, 5, 6, and 7 cards respectively. Only the top '
                    'card in each column is face-up. The remaining cards form each player\'s '
                    'face-down stock pile.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Shared Foundation Piles', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'There are 8 shared foundation piles in the center (4 suits × 2 decks). '
                    'Either player may start a foundation pile by playing an Ace of any suit. '
                    'Foundations are built up by suit: A → 2 → 3 → ... → K.\n\n'
                    'IMPORTANT: When two cards of the same suit from different decks are '
                    'both eligible for the next foundation card, track which pile belongs '
                    'to which deck by the card backs.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Tableau & Stock Rules', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Tableau rules (Klondike): Build columns downward in alternating red and '
                    'black rank order. An empty column may only be filled by a King.\n\n'
                    'Either player may play to any tableau column. If both players try to '
                    'play the same card to the same spot simultaneously, whoever places '
                    'their card first claims the spot.\n\n'
                    'Draw from your own stock pile (typically 3 cards at a time). If the '
                    'stock is exhausted, flip the discard pile to form a new stock.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Winning', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The game ends when neither player can make any more moves. Each player '
                    'counts the cards they contributed to the shared foundations '
                    '(identified by their deck\'s back design). The player with more '
                    'foundation cards wins.',
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
