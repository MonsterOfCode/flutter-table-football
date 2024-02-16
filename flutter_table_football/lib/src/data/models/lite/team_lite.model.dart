import 'package:flutter/foundation.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/core/data/models/searchable.model.dart';

/// Team Model
///
/// *[int] id (unique)
/// *[String] Name
/// *[int] points (to help calculate rankings)
/// *[List<PlayersLite>] Players

@immutable
class TeamLite implements Searchable {
  final int id; // Unique identifier
  final String name;
  final int points;
  final List<PlayerLite> players;

  const TeamLite({
    required this.id,
    required this.name,
    this.points = 0,
    required this.players,
  });

  @override
  String get searchable => "${name.toLowerCase()} ${players.map((p) => p.searchable).join(' ')}";

  TeamLite copyWith({
    int? id,
    String? name,
    int? points,
    List<PlayerLite>? players,
  }) {
    return TeamLite(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
      players: players ?? this.players,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'points': points,
      'players': players.map((x) => x.toMap()).toList(),
    };
  }

  factory TeamLite.fromMap(Map<String, dynamic> map) {
    // get the players
    List<PlayerLite> players = List.empty(growable: true);
    for (var player in map['players']) {
      players.add(PlayerLite.fromMap(player));
    }

    return TeamLite(
      id: map['id'] as int,
      name: map['name'] as String,
      points: map.containsKey('points') ? map['points'] as int : 0,
      players: players,
    );
  }

  @override
  String toString() {
    return 'TeamLite(id: $id, name: $name,  points: $points, playersLite: $players,)';
  }

  @override
  bool operator ==(covariant TeamLite other) {
    if (identical(this, other)) return true;
    return other.id == id && other.name == name && other.points == points && listEquals(other.players, players);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ points.hashCode ^ players.hashCode;
  }
}
