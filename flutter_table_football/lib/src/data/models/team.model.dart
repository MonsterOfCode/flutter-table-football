import 'package:flutter/foundation.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/models/searchable.model.dart';

/// Team Model
///
/// [int] id (unique)
///
/// [String] Name
///
/// [int] wins
///
/// [int] losses
///
/// [int] ties
///
/// [int] points (to help calculate rankings)
///
/// [double] [computed] Ratio (Games Played/Win)
///
/// [int] GF (Goals For)
///
/// [int] GA (Goals Against)
///
/// [int] [computed] GD (Goals Difference)
///
/// [List<Players>] Players

@immutable
class Team implements Searchable {
  final int id; // Unique identifier
  final String name;
  final int wins;
  final int losses;
  final int ties;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final List<Player> players;
  final List<int> lastGamesId;

  const Team({
    required this.id,
    required this.name,
    this.wins = 0,
    this.losses = 0,
    this.ties = 0,
    this.points = 0,
    this.goalsFor = 0,
    this.goalsAgainst = 0,
    this.lastGamesId = const [],
    required this.players,
  });

  /// Computed property for the team's games
  int get matches => wins + losses + ties;

  /// Computed property for the team's win percentage.
  double get ration => wins != 0 ? matches / wins : 0.0;

  /// Get the number of goals between the Goals for and against the team.
  int get goalsDiference => (goalsFor - goalsAgainst).abs();

  @override
  String get searchable => "${name.toLowerCase()} ${players.map((p) => p.searchable).join(' ')}";

  Team copyWith({
    int? id,
    String? name,
    int? wins,
    int? losses,
    int? ties,
    int? points,
    int? goalsFor,
    int? goalsAgainst,
    List<Player>? players,
    List<int>? lastGamesId,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      ties: ties ?? this.ties,
      points: points ?? this.points,
      goalsFor: goalsFor ?? this.goalsFor,
      goalsAgainst: goalsAgainst ?? this.goalsAgainst,
      players: players ?? this.players,
      lastGamesId: lastGamesId ?? this.lastGamesId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'wins': wins,
      'losses': losses,
      'ties': ties,
      'points': points,
      'goalsFor': goalsFor,
      'goalsAgainst': goalsAgainst,
      'players': players.map((x) => x.toMap()).toList(),
      'lastGamesId': lastGamesId,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    // get the players
    List<Player> players = List.empty(growable: true);
    for (var player in map['players']) {
      players.add(Player.fromMap(player));
    }

    List<int> lastGamesId = List.empty(growable: true);

    for (var gameId in map["lastGames"]) {
      var id = gameId is int ? gameId : gameId["id"];
      lastGamesId.add(id);
    }

    return Team(
      id: map['id'] as int,
      name: map['name'] as String,
      wins: map.containsKey('wins') ? map['wins'] as int : 0,
      losses: map.containsKey('losses') ? map['losses'] as int : 0,
      ties: map.containsKey('ties') ? map['ties'] as int : 0,
      points: map.containsKey('points') ? map['points'] as int : 0,
      goalsFor: map.containsKey('goalsFor') ? map['goalsFor'] as int : 0,
      goalsAgainst: map.containsKey('goalsAgainst') ? map['goalsAgainst'] as int : 0,
      players: players,
      lastGamesId: lastGamesId,
    );
  }

  @override
  String toString() {
    return 'Team(id: $id, name: $name, wins: $wins, losses: $losses, ties: $ties, points: $points, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, players: $players, lastGamesId: $lastGamesId)';
  }

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) return true;
    return other.id == id && other.name == name && other.wins == wins && other.losses == losses && other.ties == ties && other.points == points && other.goalsFor == goalsFor && other.goalsAgainst == goalsAgainst && listEquals(other.players, players) && listEquals(other.lastGamesId, lastGamesId);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ wins.hashCode ^ losses.hashCode ^ ties.hashCode ^ points.hashCode ^ goalsFor.hashCode ^ goalsAgainst.hashCode ^ players.hashCode ^ lastGamesId.hashCode;
  }
}
