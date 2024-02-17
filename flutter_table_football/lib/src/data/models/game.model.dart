import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';

/// Game Model
///
/// *[int] (id) (unique)
/// *[TeamLite] (teamA)
/// *[TeamLite] (teamB)
/// *[int] ScoreTeam1
/// *[int] ScoreTeam2
/// *[int] [computed] winTeam
/// *[DateTime] DateTime
/// *[bool] done
@immutable
class Game {
  final int id;
  final TeamLite teamA;
  final TeamLite teamB;
  final int scoreTeamA;
  final int scoreTeamB;
  final DateTime dateTime;
  final bool done;

  const Game({
    required this.id,
    required this.teamA,
    required this.teamB,
    required this.scoreTeamA,
    required this.scoreTeamB,
    required this.dateTime,
    required this.done,
  });

  /// Returns the id of the team that won the game
  ///
  /// If the game is not finished return the team that is winning
  ///
  /// If is a tie return -1
  int winTeam() {
    if (scoreTeamA == scoreTeamB) return -1;
    return scoreTeamA > scoreTeamB ? teamA.id : teamB.id;
  }

  /// Updates the score of the [team]
  ///
  /// Returns [Game] a copy of the object with the updated values
  Game updateScoreOfTeam(int teamId, {bool toIncrement = true}) {
    int? newScoreTeamA;
    int? newScoreTeamB;
    if (teamId == teamA.id) newScoreTeamA = toIncrement ? scoreTeamA + 1 : scoreTeamA - 1;
    if (teamId == teamB.id) newScoreTeamB = toIncrement ? scoreTeamB + 1 : scoreTeamB - 1;
    return copyWith(scoreTeamA: newScoreTeamA, scoreTeamB: newScoreTeamB);
  }

  int gameMinute() {
    if (done) return -1;
    return DateTime.now().difference(dateTime).inMinutes;
  }

  Game copyWith({
    int? id,
    TeamLite? teamA,
    TeamLite? teamB,
    int? scoreTeamA,
    int? scoreTeamB,
    DateTime? dateTime,
    bool? done,
  }) {
    return Game(
      id: id ?? this.id,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      scoreTeamA: scoreTeamA ?? this.scoreTeamA,
      scoreTeamB: scoreTeamB ?? this.scoreTeamB,
      dateTime: dateTime ?? this.dateTime,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'team1': teamA,
      'team2': teamB,
      'scoreTeamA': scoreTeamA,
      'scoreTeamB': scoreTeamB,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'done': done,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as int,
      teamA: TeamLite.fromMap(map['teamA']),
      teamB: TeamLite.fromMap(map['teamB']),
      scoreTeamA: map['scoreTeamA'] as int,
      scoreTeamB: map['scoreTeamB'] as int,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      done: map['done'] as bool,
    );
  }

  @override
  String toString() {
    return 'Game(id: $id, teamA: $teamA, teamB: $teamB, scoreTeamA: $scoreTeamA, scoreTeamB: $scoreTeamB, dateTime: $dateTime, done: $done)';
  }

  @override
  bool operator ==(covariant Game other) {
    if (identical(this, other)) return true;

    return other.id == id && other.teamA == teamA && other.teamB == teamB && other.scoreTeamA == scoreTeamA && other.scoreTeamB == scoreTeamB && other.dateTime == dateTime && other.done == done;
  }

  @override
  int get hashCode {
    return id.hashCode ^ teamA.hashCode ^ teamB.hashCode ^ scoreTeamA.hashCode ^ scoreTeamB.hashCode ^ dateTime.hashCode ^ done.hashCode;
  }
}
