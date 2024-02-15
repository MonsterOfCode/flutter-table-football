// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

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

  const Team({
    required this.id,
    required this.name,
    required this.wins,
    required this.losses,
    required this.ties,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
  });

  Team copyWith({
    int? id,
    String? name,
    int? wins,
    int? losses,
    int? ties,
    int? points,
    int? goalsFor,
    int? goalsAgainst,
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
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as int,
      name: map['name'] as String,
      wins: map['wins'] as int,
      losses: map['losses'] as int,
      ties: map['ties'] as int,
      points: map['points'] as int,
      goalsFor: map['goalsFor'] as int,
      goalsAgainst: map['goalsAgainst'] as int,
    );
  }

  /// Computed property for the team's games
  int get match => wins + losses + ties;

  /// Computed property for the team's win percentage.
  double get ration => match / wins;

  /// Get the number of goals between the Goals for and against the team.
  int get goalsDiference => (goalsFor - goalsAgainst).abs();

  @override
  String toString() {
    return 'Team(id: $id, name: $name, wins: $wins, losses: $losses, ties: $ties, points: $points, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst)';
  }

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.wins == wins && other.losses == losses && other.ties == ties && other.points == points && other.goalsFor == goalsFor && other.goalsAgainst == goalsAgainst;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ wins.hashCode ^ losses.hashCode ^ ties.hashCode ^ points.hashCode ^ goalsFor.hashCode ^ goalsAgainst.hashCode;
  }
}
