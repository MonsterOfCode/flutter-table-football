import 'dart:math';

import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';

class PlayersProvider {
  /// Request to the API to create a new Player and return it as a model if success
  ///
  /// If fail returns null
  static Future<Player?> create(Map<String, String> data) async {
    await Future.delayed(const Duration(seconds: 2));
    return const Player(name: "New Player", points: 0);
  }

  /// Request to the API by the list of all PlayersLite because it to show on list
  ///
  /// If fail returns an empty List
  static Future<List<PlayerLite>> fetch() async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticPlayersLite).catchError((onError) {
      return List<PlayerLite>.empty(growable: true);
    });
  }

  /// Request to the API by the top 10 playersLite
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
