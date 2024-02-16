import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';

/// Game Model
///
/// *[int] (id) (unique)
/// *[TeamLite] (team1)
/// *[TeamLite] (team2)
/// *[int] ScoreTeam1
/// *[int] ScoreTeam2
/// *[int] [computed] winTeam
/// *[DateTime] DateTime
/// *[bool] done
@immutable
class Game {
  final int id;
  final TeamLite team1;
  final TeamLite team2;
  final int scoreTeam1;
  final int scoreTeam2;
  final DateTime dateTime;
  final bool done;

  const Game({
    required this.id,
    required this.team1,
    required this.team2,
    required this.scoreTeam1,
    required this.scoreTeam2,
    required this.dateTime,
    required this.done,
  });

  /// Returns the id of the team that won the game
  ///
  /// If the game is not finished return the team that is winning
  ///
  /// If is a tie return null
  TeamLite? winTeam() {
    if (scoreTeam1 == scoreTeam2) return null;
    return scoreTeam1 > scoreTeam2 ? team1 : team2;
  }

  /// Returns the score of the [team]
  int scoreOfTeam(team) {
    if (team.id == team1.id) return scoreTeam1;
    if (team.id == team2.id) return scoreTeam2;
    throw 'The team do not belongs to this game';
  }

  Game copyWith({
    int? id,
    TeamLite? team1,
    TeamLite? team2,
    int? scoreTeam1,
    int? scoreTeam2,
    DateTime? dateTime,
    bool? done,
  }) {
    return Game(
      id: id ?? this.id,
      team1: team1 ?? this.team1,
      team2: team2 ?? this.team2,
      scoreTeam1: scoreTeam1 ?? this.scoreTeam1,
      scoreTeam2: scoreTeam2 ?? this.scoreTeam2,
      dateTime: dateTime ?? this.dateTime,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'team1': team1,
      'team2': team2,
      'scoreTeam1': scoreTeam1,
      'scoreTeam2': scoreTeam2,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'done': done,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] as int,
      team1: TeamLite.fromMap(map['team1']),
      team2: TeamLite.fromMap(map['team2']),
      scoreTeam1: map['scoreTeam1'] as int,
      scoreTeam2: map['scoreTeam2'] as int,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      done: map['done'] as bool,
    );
  }

  @override
  String toString() {
    return 'Game(id: $id, team1: $team1, team2: $team2, scoreTeam1: $scoreTeam1, scoreTeam2: $scoreTeam2, dateTime: $dateTime, done: $done)';
  }

  @override
  bool operator ==(covariant Game other) {
    if (identical(this, other)) return true;

    return other.id == id && other.team1 == team1 && other.team2 == team2 && other.scoreTeam1 == scoreTeam1 && other.scoreTeam2 == scoreTeam2 && other.dateTime == dateTime && other.done == done;
  }

  @override
  int get hashCode {
    return id.hashCode ^ team1.hashCode ^ team2.hashCode ^ scoreTeam1.hashCode ^ scoreTeam2.hashCode ^ dateTime.hashCode ^ done.hashCode;
  }
}
