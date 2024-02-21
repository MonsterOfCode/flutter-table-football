import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/providers/players.provider.dart';
import 'package:flutter_table_football/src/data/storage/auth.storage.dart';

class AuthRepository {
  /// Request to be created a new Auth by a Map using PlayerRepository
  ///
  /// If something wrong returns null
  static Future<Player?> create(Map<String, String> data) async {
    return PlayersProvider.create(data);
  }

  /// Request to identify and authenticate player
  ///
  /// If something wrong returns null
  static Future<Player?> authenticate(String nickname, bool toCreateIfDoNotExists) async {
    return PlayersProvider.authenticate(nickname, toCreateIfDoNotExists).then((player) async {
      if (player != null) {
        await AuthStorage().write(player);
      }
      return player;
    });
  }

  /// Fetch the player authenticated to local Storage
  static Future<Player?> get() async {
    return AuthStorage().read().then((player) => player);
  }

  /// Fetch the player authenticated to local Storage
  static Future<void> logout() async {
    return AuthStorage().clean();
  }
}
