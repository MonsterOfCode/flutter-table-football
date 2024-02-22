import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/models/searchableListItem.model.dart';

/// IMPORTANT Lite Version
///
/// A LITE version of Player Model
///
/// * [String] name (unique)
/// * [int] points
@immutable
class PlayerLite extends SearchableListItem {
  final String name;
  final int points;

  const PlayerLite({
    required this.name,
    this.points = 0,
  });

  PlayerLite copyWith({
    String? name,
    int? points,
  }) {
    return PlayerLite(
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

  factory PlayerLite.fromMap(Map<String, dynamic> map) {
    return PlayerLite(
      name: map['name'] as String,
      points: map.containsKey('points') ? map['points'] as int : 0,
    );
  }

  @override
  String get searchable => name.toLowerCase();

  @override
  String get title => name;

  @override
  String get trailing => "$points pts";

  @override
  String toString() {
    return 'PlayerLite(name: $name,  points: $points)';
  }

  @override
  bool operator ==(covariant PlayerLite other) {
    if (identical(this, other)) return true;
    return other.name == name && other.points == points;
  }

  @override
  int get hashCode => name.hashCode ^ points.hashCode;
}
