import 'package:flutter/material.dart';

class GoFishRulesScreen extends StatelessWidget {
  const GoFishRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play Go Fish'),
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
                    'Collect the most sets of four matching cards (books). The player with the '
                    'most books when all 13 sets are completed wins.',
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
                    'Use a standard 52-card deck with 2–6 players. Deal 7 cards to each player '
                    '(5 cards each if 4 or more players). Place the remaining cards face down '
                    'as the "ocean" (draw pile).',
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
                    'On your turn, ask any other player for a specific rank (e.g., "Do you have '
                    'any 7s?"). You must already hold at least one card of that rank.\n\n'
                    'If the asked player has cards of that rank, they must give all of them to you '
                    'and you take another turn.\n\n'
                    'If the asked player has none, they say "Go Fish!" and you draw one card from '
                    'the ocean. If the drawn card is the rank you asked for, show it and take '
                    'another turn. Otherwise, play passes left.\n\n'
                    'When you collect all four cards of a rank (a "book"), place them face-up in '
                    'front of you.',
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
                    'The game ends when all 13 books have been completed or a player runs out '
                    'of cards and the ocean is empty. The player with the most books wins.',
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
                    'Enter each player\'s number of books collected at the end of the game. '
                    'The player with the most books wins.',
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
              title: Text('Setup & Deal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'Players: 2–6. Use a standard 52-card deck.\n\n'
                    'Deal cards: 7 cards each with 2 players; 5 cards each with 3–6 players. '
                    'Place the remaining cards face-down in the center as the "ocean" '
                    '(or "pond"). Players hold their cards so others cannot see them.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Taking a Turn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'On your turn, choose any opponent and ask them for a specific rank '
                    '(e.g., "Do you have any sevens?"). You must already hold at least one '
                    'card of that rank in your hand.\n\n'
                    'If the opponent has cards of that rank: they must give you ALL of them. '
                    'You may then take another turn.\n\n'
                    'If the opponent has none: they say "Go Fish!" and you draw the top card '
                    'from the ocean. If the card you draw matches the rank you asked for, '
                    'show it and take another turn. Otherwise, your turn ends and play '
                    'passes to the left.',
                    style: TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Books & Winning', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              leading: Icon(Icons.menu_book),
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    'A "book" is all 4 cards of the same rank (e.g., all four 7s). When '
                    'you collect all 4 cards of a rank, immediately place them face-up in '
                    'front of you as a completed book.\n\n'
                    'The game ends when all 13 books have been completed, OR a player runs '
                    'out of cards and the ocean is empty. Players who run out of cards '
                    'during play must draw 1 card from the ocean to continue (if available).\n\n'
                    'Count books. The player who collected the most books wins.',
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
