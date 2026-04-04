class Player {
  final String name;
  int score;
  List<int> gameScores;
  List<String> scoreTypes; // New field to track score types (regular, knock, gin)

  Player({required this.name}) : score = 0, gameScores = [], scoreTypes = [];

  // Constructor for restoring from storage
  Player.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        score = json['score'],
        gameScores = List<int>.from(json['gameScores']),
        scoreTypes = json.containsKey('scoreTypes') 
            ? List<String>.from(json['scoreTypes']) 
            : List.filled((json['gameScores'] as List).length, 'regular');  // Default for backward compatibility

  // Convert player to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'gameScores': gameScores,
      'scoreTypes': scoreTypes,
    };
  }

  void addPoints(int points) {
    score += points;
    gameScores.add(points);
    scoreTypes.add('regular');  // Default score type
  }
  
  // New method to add points with a specific score type
  void addPointsWithType(int points, String scoreType) {
    score += points;
    gameScores.add(points);
    scoreTypes.add(scoreType);
  }

  void resetScore() {
    score = 0;
    gameScores = [];
    scoreTypes = [];
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
  
  // New method to edit both score and score type
  void editRoundScoreWithType(int roundIndex, int newScore, String newScoreType) {
    if (roundIndex >= 0 && roundIndex < gameScores.length) {
      // Calculate the difference between the new and old score
      final oldScore = gameScores[roundIndex];
      final scoreDifference = newScore - oldScore;
      
      // Update the score at the specific round
      gameScores[roundIndex] = newScore;
      scoreTypes[roundIndex] = newScoreType;
      
      // Update the total score
      score += scoreDifference;
    }
  }
}
