// Game Model
class Game {
  int idTeam1; // Composed Key, Unique Constraint
  int idTeam2; // Composed Key, Unique Constraint
  int scoreTeam1;
  int scoreTeam2;
  DateTime dateTime;
  bool done;

  Game({
    required this.idTeam1,
    required this.idTeam2,
    required this.scoreTeam1,
    required this.scoreTeam2,
    required this.dateTime,
    required this.done,
  });

  /// Returns the id of the team that won the game
  ///
  /// If the game is not finished yet returns -1
  ///
  /// If is a tie return 0
  int winTeamId() {
    if (!done) return -1;
    if (scoreTeam1 == scoreTeam2) return 0;
    return scoreTeam1 > scoreTeam2 ? idTeam1 : idTeam2;
  }
}
