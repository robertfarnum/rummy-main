class Player {
  final String name;
  int score;
  List<int> gameScores;

  Player({required this.name}) : score = 0, gameScores = [];

  // Constructor for restoring from storage
  Player.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        score = json['score'],
        gameScores = List<int>.from(json['gameScores']);

  // Convert player to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'gameScores': gameScores,
    };
  }

  void addPoints(int points) {
    score += points;
    gameScores.add(points);
  }

  void resetScore() {
    score = 0;
    gameScores = [];
  }

  void editRoundScore(int roundIndex, int newScore) {
    if (roundIndex >= 0 && roundIndex < gameScores.length) {
      // Calculate the difference between the new and old score
      final oldScore = gameScores[roundIndex];
      final scoreDifference = newScore - oldScore;
      
      // Update the score at the specific round
      gameScores[roundIndex] = newScore;
      
      // Update the total score
      score += scoreDifference;
    }
  }
}
