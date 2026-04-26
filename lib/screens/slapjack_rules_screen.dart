import 'package:flutter/material.dart';

class SlapjackRulesScreen extends StatelessWidget {
  const SlapjackRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Slapjack'),
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
                    'Win all the cards by being the first to slap each Jack as it is played.',
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
                    'Use a standard 52-card deck with 2–8 players. Deal all cards face down as '
                    'evenly as possible. Players do not look at their cards — they keep them in a '
                    'face-down pile in front of them.',
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
                    'Players take turns flipping their top card onto a central pile. When a Jack '
                    'appears, all players race to slap the pile. The first player to slap the Jack '
                    'wins the entire pile and adds it to the bottom of their stack. If you slap a '
                    'card that is not a Jack, you must give one card to the player who played that '
                    'card. If you run out of cards, you get one chance to slap back in on the next Jack.',
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
                    'The game continues until one player has collected all 52 cards. That player wins!',
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
                    'Since Slapjack has no point system, this app tracks games won per session. '
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
