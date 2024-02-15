import 'package:flutter/material.dart';

/// Game Model
///
/// [int] (idTeam1) (Composed Key, Unique Constraint),
///
/// [int] (idTeam2) (Composed Key, Unique Constraint)
///
/// [int] ScoreTeam1
///
/// [int] ScoreTeam2
///
/// [int] [computed] winTeam
///
/// [DateTime] DateTime
///
/// [bool] done
@immutable
class Game {
  final int idTeam1; // Composed Key, Unique Constraint
  final int idTeam2; // Composed Key, Unique Constraint
  final int scoreTeam1;
  final int scoreTeam2;
  final DateTime dateTime;
  final bool done;

  const Game({
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

  Game copyWith({
    int? idTeam1,
    int? idTeam2,
    int? scoreTeam1,
    int? scoreTeam2,
    DateTime? dateTime,
    bool? done,
  }) {
    return Game(
      idTeam1: idTeam1 ?? this.idTeam1,
      idTeam2: idTeam2 ?? this.idTeam2,
      scoreTeam1: scoreTeam1 ?? this.scoreTeam1,
      scoreTeam2: scoreTeam2 ?? this.scoreTeam2,
      dateTime: dateTime ?? this.dateTime,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTeam1': idTeam1,
      'idTeam2': idTeam2,
      'scoreTeam1': scoreTeam1,
      'scoreTeam2': scoreTeam2,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'done': done,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      idTeam1: map['idTeam1'] as int,
      idTeam2: map['idTeam2'] as int,
      scoreTeam1: map['scoreTeam1'] as int,
      scoreTeam2: map['scoreTeam2'] as int,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      done: map['done'] as bool,
    );
  }

  @override
  String toString() {
    return 'Game(idTeam1: $idTeam1, idTeam2: $idTeam2, scoreTeam1: $scoreTeam1, scoreTeam2: $scoreTeam2, dateTime: $dateTime, done: $done)';
  }

  @override
  bool operator ==(covariant Game other) {
    if (identical(this, other)) return true;

    return other.idTeam1 == idTeam1 && other.idTeam2 == idTeam2 && other.scoreTeam1 == scoreTeam1 && other.scoreTeam2 == scoreTeam2 && other.dateTime == dateTime && other.done == done;
  }

  @override
  int get hashCode {
    return idTeam1.hashCode ^ idTeam2.hashCode ^ scoreTeam1.hashCode ^ scoreTeam2.hashCode ^ dateTime.hashCode ^ done.hashCode;
  }
}