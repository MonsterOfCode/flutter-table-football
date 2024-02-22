import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/providers/players.provider.dart';

class PlayersRepository {
  /// Request to be created a new Player by a Map
  ///
  /// If something wrong returns null
  static Future<Player?> create(Map<String, dynamic> data) async {
    return PlayersProvider.create(data);
  }

  /// Request the full data of a player
  ///
  /// If something wrong returns null
  static Future<Player?> loadProfile(String nickname) async {
    return PlayersProvider.getByName(nickname);
  }

  /// Fetch the teams registered on the platform
  static Future<List<PlayerLite>> getByQuery({String query = ''}) async {
    return PlayersProvider.getByQuery(query: query);
  }

  /// Check if a nickname is available
  static Future<dynamic> validateNickname(String nickname) async {
    return PlayersProvider.validateNickname(nickname);
  }

  /// Fetch the top 10 players
  static Future<List<Player>> getTop10() async {
    return PlayersProvider.fetchTop10();
  }
}
