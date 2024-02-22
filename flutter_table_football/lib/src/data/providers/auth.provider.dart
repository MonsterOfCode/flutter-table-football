import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/iterable.extension.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';

class AuthProvider {
  /// Request to the API to authenticate a Player and return it as a model if success
  ///
  /// If fail returns null
  static Future<Player?> authenticate(String nickname) async {
    // TODO Connect to the real API
    await Future.delayed(const Duration(milliseconds: 500));
    Player? p = staticPlayers.firstWhereOrNull((element) => element.name.toLowerCase() == nickname);
    return p;
  }
}
