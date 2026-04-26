import 'package:flutter/material.dart';

class WarRulesScreen extends StatelessWidget {
  const WarRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play War'),
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
                    'Win all the cards by playing higher cards than your opponent.',
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
                    'Use a standard 52-card deck with 2–4 players. Deal all cards face down as '
                    'evenly as possible. Cards rank Ace (high) down to 2 (low).',
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
                    'All players simultaneously flip their top card face up. The highest card wins '
                    'all the flipped cards, which go to the bottom of the winner\'s pile.\n\n'
                    'If two or more players tie for the highest card, a "war" occurs: each tied '
                    'player places one card face down, then flips another card face up. The highest '
                    'new card wins all the cards from the war. If there\'s another tie, the war '
                    'continues.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Winning', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              leading: Icon(Icons.emoji_events),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'The game ends when one player collects all the cards, or when players agree '
                    'to stop (the player with the most cards wins).',
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
                    'Since War has no point system, this app tracks games won per session. '
                    'After each game, select the winner to record a win.',
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
