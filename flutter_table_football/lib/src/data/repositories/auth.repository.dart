import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/providers/players.provider.dart';

class AuthRepository {
  /// Request to be created a new Auth by a Map using PlayerRepository
  ///
  /// If something wrong returns null
  static Future<Player?> create(Map<String, String> data) async {
    return PlayersProvider.create(data);
  }

  /// Fetch all the players registered at the platform
  static Future<Player> get() async {
    // check on local storage if there is any player saved
    return PlayersProvider.getByName("name");
  }
}
