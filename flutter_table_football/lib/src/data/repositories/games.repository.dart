import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/providers/games.provider.dart';

class GamesRepository {
  /// Request to be created a new Game by a Map
  ///
  /// If something wrong returns null
  static Future<Game?> create(Map<String, dynamic> data) async {
    return GamesProvider.create(data);
  }

  /// Get the games by list of IDs
  static Future<List<Game>> getGamesById(List<int> ids) async {
    //TODO check if exists on local storage first and then request to server
    return GamesProvider.getByID(ids);
  }

  /// Fetch all the players registered at the platform
  static Future<List<Game>> getAll() async {
    return GamesProvider.fetch();
  }
}
