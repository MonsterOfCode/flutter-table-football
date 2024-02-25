import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/models/searchable.model.dart';
import 'package:flutter_table_football/src/core/data/models/stats.model.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';

/// Player Model
///
/// * [String] name (unique)
/// * [int] points
/// * [int] wins
/// * [int] ties
/// * [int] losses
/// * [int] goalsFor
/// * [int] goalsAgainst
@immutable
class Player extends Stats implements Searchable {
  final List<Team> topTeams;

  const Player({
    required super.name,
    super.wins = 0,
    super.losses = 0,
    super.ties = 0,
    super.goalsFor = 0,
    super.goalsAgainst = 0,
    super.points = 0,
    this.topTeams = const <Team>[],
  });

  Player copyWith({
    String? name,
    int? points,
    int? wins,
    int? losses,
    int? ties,
    int? goalsFor,
    int? goalsAgainst,
    List<Team>? topTeams,
  }) {
    return Player(
      name: name ?? this.name,
      points: points ?? this.points,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      ties: ties ?? this.ties,
      goalsFor: goalsFor ?? this.goalsFor,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      topTeams: topTeams ?? this.topTeams,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'points': points,
      'wins': wins,
      'losses': losses,
      'ties': ties,
      'goalsFor': goalsFor,
      'goalsAgainst': goalsAgainst,
      'topTeams': topTeams.map((x) => x.toMap()).toList(),
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    // get the teams
    List<Team> teams = List.empty(growable: true);
    for (var team in map['topTeams']) {
      teams.add(Team.fromMap(team));
    }

    return Player(
      name: map['name'] as String,
      wins: map.containsKey('wins') ? map['wins'] as int : 0,
      losses: map.containsKey('losses') ? map['losses'] as int : 0,
      points: map.containsKey('points') ? map['points'] as int : 0,
      goalsFor: map.containsKey('goalsFor') ? map['goalsFor'] as int : 0,
      goalsAgainst: map.containsKey('goalsAgainst') ? map['goalsAgainst'] as int : 0,
      topTeams: teams,
    );
  }

  // convert a Player model to a PlayerLite
  PlayerLite get toLite => PlayerLite(name: name, points: points);

  @override
  String get searchable => name.toLowerCase();

  @override
  String toString() {
    return 'Player(name: $name, wins: $wins, losses: $losses, ties: $ties, points: $points, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, topTeams: $topTeams)';
  }

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;
    return other.name == name && other.wins == wins && other.losses == losses && other.ties == ties && other.points == points && other.goalsFor == goalsFor && other.goalsAgainst == goalsAgainst && listEquals(other.topTeams, topTeams);
  }

  @override
  int get hashCode => name.hashCode ^ wins.hashCode ^ losses.hashCode ^ ties.hashCode ^ points.hashCode ^ goalsFor.hashCode ^ goalsAgainst.hashCode ^ topTeams.hashCode;
}
