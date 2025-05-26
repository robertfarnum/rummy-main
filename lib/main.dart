import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RummyScoreApp());
}

class RummyScoreApp extends StatelessWidget {
  const RummyScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gin Rummy Scorekeeper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
