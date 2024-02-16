import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';

class GamesProvider {
  /// Request to the API to create a new Team and return it as a model if success
  ///
  /// If fail returns null
  static Future<Game?> create(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 2));
    return staticGames.last;
  }

  /// Request to the API by the list of all Players
  ///
  /// If fail returns an empty List
  static Future<List<Game>> fetch() async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticGames).catchError((onError) {
      return List<Game>.empty(growable: true);
    });
  }
}
