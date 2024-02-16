import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/providers/players.provider.dart';

class PlayersRepository {
  /// Request to be created a new Player by a Map
  ///
  /// If something wrong returns null
  static Future<Player?> create(Map<String, String> data) async {
    return PlayersProvider.create(data);
  }

  /// Fetch all the players registered at the platform
  static Future<List<PlayerLite>> getAll() async {
    return PlayersProvider.fetch();
  }

  /// Fetch the top 10 players
  static Future<List<Player>> getTop10() async {
    return PlayersProvider.fetchTop10();
  }
}
