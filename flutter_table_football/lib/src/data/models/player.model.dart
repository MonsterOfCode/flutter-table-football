import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/models/searchable.model.dart';

/// Player Model
///
/// [String] name (unique)
///
/// [int] points (to help calculate rankings)
@immutable
class Player implements Searchable {
  final String name;
  final int points;

  const Player({
    required this.name,
    this.points = 0,
  });

  Player copyWith({
    String? name,
    int? points,
  }) {
    return Player(
      name: name ?? this.name,
      points: points ?? this.points,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'points': points,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'] as String,
      points: map['points'] as int,
    );
  }

  @override
  String get searchable => name.toLowerCase();

  @override
  String toString() => 'Player(name: $name, points: $points)';

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;
    return other.name == name && other.points == points;
  }

  @override
  int get hashCode => name.hashCode ^ points.hashCode;
}
