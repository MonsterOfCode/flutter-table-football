// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';

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
class Team {
  final int id; // Unique identifier
  final String name;
  final int wins;
  final int losses;
  final int ties;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final List<Player> players;

  const Team({
    required this.id,
    required this.name,
    required this.wins,
    required this.losses,
    required this.ties,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.players,
  });

  /// Computed property for the team's games
  int get match => wins + losses + ties;

  /// Computed property for the team's win percentage.
  double get ration => match / wins;

  /// Get the number of goals between the Goals for and against the team.
  int get goalsDiference => (goalsFor - goalsAgainst).abs();

  /// Computed property to be used during the search process
  String get searchable => name.toLowerCase();

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
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    // get the players
    List<Player> players = List.empty(growable: true);
    for (var player in map['players']) {
      players.add(Player.fromMap(player));
    }

    return Team(
      id: map['id'] as int,
      name: map['name'] as String,
      wins: map['wins'] as int,
      losses: map['losses'] as int,
      ties: map['ties'] as int,
      points: map['points'] as int,
      goalsFor: map['goalsFor'] as int,
      goalsAgainst: map['goalsAgainst'] as int,
      players: players,
    );
  }

  @override
  String toString() {
    return 'Team(id: $id, name: $name, wins: $wins, losses: $losses, ties: $ties, points: $points, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, players: $players)';
  }

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) return true;
    return other.id == id && other.name == name && other.wins == wins && other.losses == losses && other.ties == ties && other.points == points && other.goalsFor == goalsFor && other.goalsAgainst == goalsAgainst && listEquals(other.players, players);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ wins.hashCode ^ losses.hashCode ^ ties.hashCode ^ points.hashCode ^ goalsFor.hashCode ^ goalsAgainst.hashCode ^ players.hashCode;
  }
}
