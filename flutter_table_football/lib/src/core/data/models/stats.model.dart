/// Stats Model
///
/// A model that implements the necessary attributes to be displayed on the Stats Table
/// * [int] points
/// * [int] wins
/// * [int] ties
/// * [int] losses
/// * [int] goalsFor
/// * [int] goalsAgainst
abstract class Stats {
  final String name;
  final int wins;
  final int losses;
  final int ties;
  final int points;
  final int goalsFor;
  final int goalsAgainst;

  const Stats({
    required this.name,
    required this.wins,
    required this.losses,
    required this.ties,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
  });

  /// Computed property for the team's games
  int get matches => wins + losses + ties;

  /// Computed property for the team's win percentage.
  double get ratio => wins != 0 ? matches / wins : 0.0;

  /// Get the number of goals between the Goals for and against the team.
  int get goalsDiference => (goalsFor - goalsAgainst).abs();
}
