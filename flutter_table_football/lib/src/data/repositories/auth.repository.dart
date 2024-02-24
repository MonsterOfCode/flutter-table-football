import 'package:dio/dio.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/providers/auth.provider.dart';
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
  static Future<Player?> authenticate(String nickname) async {
    return AuthProvider.authenticate(nickname).then((response) async {
      if (response.statusCode == 200) {
        return Player.fromMap(response.data["data"]);
      }
    }).onError((error, stackTrace) {
      if (error is DioException) {
        // api returns 404 if no player found
        if (error.response?.statusCode == 404) {
          return null;
        }
        throw error;
      }
      return null;
    });
  }

  /// Fetch the player authenticated to local Storage
  static Future<Player?> get() async {
    return AuthStorage().read();
  }

  /// Fetch the player authenticated to local Storage
  static Future<void> logout() async {
    return AuthStorage().clean();
  }
}
