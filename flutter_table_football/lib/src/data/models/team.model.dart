import 'package:flutter/foundation.dart';
import 'package:flutter_table_football/src/core/data/models/stats.model.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/core/data/models/searchable.model.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';

/// Team Model
///
/// *[int] id (unique)
/// *[String] Name
/// *[int] wins
/// *[int] losses
/// *[int] ties
/// *[int] points (to help calculate rankings)
/// *[double] [computed] Ratio (Games Played/Win)
/// *[int] GF (Goals For)
/// *[int] GA (Goals Against)
/// *[int] [computed] GD (Goals Difference)
/// *[List<Players>] Players
/// *[List<Game>] lastGames

@immutable
class Team extends Stats implements Searchable {
  final int id; // Unique identifier
  final List<PlayerLite> players;
  final List<Game> lastGames;

  const Team({
    required this.id,
    required super.name,
    super.wins = 0,
    super.losses = 0,
    super.ties = 0,
    super.points = 0,
    super.goalsFor = 0,
    super.goalsAgainst = 0,
    this.lastGames = const [],
    required this.players,
  });

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
    List<PlayerLite>? players,
    List<Game>? lastGames,
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
      lastGames: lastGames ?? this.lastGames,
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
      'lastGames': lastGames,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    // get the players
    List<PlayerLite> players = List.empty(growable: true);
    for (var player in map['players']) {
      players.add(PlayerLite.fromMap(player));
    }

    // get the players
    List<Game> lastGames = List.empty(growable: true);
    for (var game in map['lastGames']) {
      lastGames.add(Game.fromMap(game));
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
      lastGames: lastGames,
    );
  }

  // convert a Team model to a TeamLite
  TeamLite get toLite => TeamLite(id: id, name: name, players: players);

  @override
  String toString() {
    return 'Team(id: $id, name: $name, wins: $wins, losses: $losses, ties: $ties, points: $points, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, players: $players, lastGamesId: $lastGames)';
  }

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) return true;
    return other.id == id && other.name == name && other.wins == wins && other.losses == losses && other.ties == ties && other.points == points && other.goalsFor == goalsFor && other.goalsAgainst == goalsAgainst && listEquals(other.players, players) && listEquals(other.lastGames, lastGames);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ wins.hashCode ^ losses.hashCode ^ ties.hashCode ^ points.hashCode ^ goalsFor.hashCode ^ goalsAgainst.hashCode ^ players.hashCode ^ lastGames.hashCode;
  }
}
