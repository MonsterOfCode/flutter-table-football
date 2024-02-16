import 'dart:math';

import 'package:flutter_table_football/src/data/models/player.model.dart';

List<Player> staticPlayers = [
  const Player(name: "Player 1", points: 150),
  const Player(name: "Player 2", points: 15),
  const Player(name: "Player 3", points: 10),
  const Player(name: "Player 4", points: 9),
  const Player(name: "Player 5", points: 6),
  const Player(name: "Player 6", points: 5),
];

class PlayersProvider {
  /// Request to the API to create a new Player and return it as a model if success
  ///
  /// If fail returns null
  static Future<Player?> create(Map<String, String> data) async {
    await Future.delayed(const Duration(seconds: 2));
    return const Player(name: "New Player", points: 0);
  }

  /// Request to the API by the list of all Players
  ///
  /// If fail returns an empty List
  static Future<List<Player>> fetch() async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticPlayers).catchError((onError) {
      return List<Player>.empty(growable: true);
    });
  }

  /// Request to the API by the top 10 players
  ///
  /// If fail returns an empty List
  static Future<List<Player>> fetchTop10() async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticPlayers).catchError((onError) {
      return List<Player>.empty(growable: true);
    });
  }

  /// Request to the API a player by name
  ///
  /// If fail returns null
  static Future<Player> getByName(String name) async {
    return await Future.delayed(const Duration(seconds: 2)).then(
      (value) => staticPlayers[Random().nextInt(staticPlayers.length - 1)],
    );
  }
}
