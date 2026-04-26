import 'package:flutter/material.dart';

class CribbageRulesScreen extends StatelessWidget {
  const CribbageRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Cribbage'),
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
                    'Be the first player to reach 121 points (or "peg out"). Points are scored '
                    'during play and by making combinations in your hand. Cribbage is traditionally '
                    'played with a pegging board to track scores.',
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
                    'Use a standard 52-card deck with 2–4 players. For 2 players, deal 6 cards each. '
                    'Each player discards 2 cards face down to form the "crib" (an extra hand that '
                    'belongs to the dealer). Cut the remaining deck to reveal the "starter" card.',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('The Play (Pegging)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        'Players alternate playing cards face up, keeping a running total. Face cards '
                        'count 10, Aces count 1, number cards are face value. The total cannot exceed '
                        '31. If you cannot play without exceeding 31, say "Go" and your opponent '
                        'continues. Points are scored for reaching exactly 15 or 31, pairs, and runs '
                        'during play.',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                      SizedBox(height: 12),
                      Text('The Show (Counting Hands)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(
                        'After play, each player counts their hand (4 cards plus the starter) for:\n'
                        '• Fifteens: Any combination totaling 15 = 2 points\n'
                        '• Pairs: Two cards of the same rank = 2 points\n'
                        '• Runs: Three or more consecutive cards = 1 point per card\n'
                        '• Flush: Four cards of the same suit = 4 points (5 if starter matches)\n'
                        '• Nobs: Jack of the starter\'s suit = 1 point',
                        style: TextStyle(fontSize: 15, height: 1.5),
                      ),
                    ],
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
                    'Points are accumulated from both the play phase (pegging) and the show phase '
                    '(counting hands). The dealer also scores the crib. Non-dealer counts first, '
                    'then dealer counts hand, then dealer counts crib.',
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
                    'The first player to reach 121 points wins. Points can be scored at any time '
                    'during play or counting — the game ends immediately when someone reaches 121.',
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
                    'Enter each player\'s total points per hand (combining pegging and show points). '
                    'The app tracks cumulative scores. First player to reach the target (default 121) wins.',
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
