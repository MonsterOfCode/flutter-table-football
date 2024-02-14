/// Team Model
class Team {
  int id; // Unique identifier
  String name;
  int wins;
  int losses;
  int points;
  double ratio;
  int gf;
  int ga;
  int gd;

  Team({
    required this.id,
    required this.name,
    required this.wins,
    required this.losses,
    required this.points,
    required this.ratio,
    required this.gf,
    required this.ga,
    required this.gd,
  });
}
