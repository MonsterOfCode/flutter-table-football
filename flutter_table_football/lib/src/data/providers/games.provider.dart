import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/iterable.extension.dart';
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

  /// Request to the API to add a new goal to a team
  ///
  ///Return the game model to update in UI with the new score and other update on new updates
  ///
  ///We sent the current score to prevent multiple increments when called
  ///on diferente devices for the same goal and team
  ///
  /// If fail returns null
  static Future<Game?> updateTeamGoal(int gameId, int teamId, int currentScore, {bool toIncrement = true}) async {
    Game? game = staticGames.firstWhereOrNull((element) => element.id == gameId);
    if (game != null) {
      game = game.updateScoreOfTeam(teamId, toIncrement: toIncrement);
    }
    return await Future.delayed(const Duration(seconds: 2)).then((value) => game);
  }
}
