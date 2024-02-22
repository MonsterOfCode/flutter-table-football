import 'dart:math';

import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/iterable.extension.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';

class PlayersProvider {
  /// Request to the API to create a new Player and return it as a model if success
  ///
  /// If fail returns null
  static Future<Player?> create(Map<String, dynamic> data) async {
    // TODO Connect to the real API
    await Future.delayed(const Duration(milliseconds: 500));
    return const Player(name: "New Player", points: 0);
  }

  /// Request to the API by the full data of a player
  ///
  /// If fail returns null
  static Future<Player?> requestProfile(String nickname) async {
    // TODO Connect to the real API
    await Future.delayed(const Duration(milliseconds: 500));
    return staticPlayers.firstWhereOrNull((element) => element.name == nickname);
  }

  /// Request from the API for a list of Players using a query
  ///
  /// If fail returns null
  static Future<List<PlayerLite>> getByQuery({String query = ''}) async {
    // TODO Connect to the real API
    await Future.delayed(const Duration(milliseconds: 500));
    return staticPlayersLite.where((element) => element.searchable.contains(query)).toList();
  }

  /// Request to the API check if the nickname is available
  ///
  /// [true] the nickname is available
  /// if not available it will return the error Map
  static Future<dynamic> validateNickname(String nickname) async {
    // TODO Connect to the real API
    await Future.delayed(const Duration(milliseconds: 500));
    return staticPlayersLite.firstWhereOrNull((element) => element.name == nickname) != null ? staticApiErrorResponse : true;
  }

  /// Request to the API by the top 10 playersLite
  ///
  /// If fail returns an empty List
  static Future<List<Player>> fetchTop10() async {
    // TODO Connect to the real API
    return await Future.delayed(const Duration(milliseconds: 500)).then((value) => staticPlayers).catchError((onError) {
      return List<Player>.empty(growable: true);
    });
  }

  /// Request to the API a player by name
  ///
  /// If fail returns null
  static Future<Player> getByName(String name) async {
    // TODO Connect to the real API
    return await Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => staticPlayers[Random().nextInt(staticPlayers.length - 1)],
    );
  }
}
