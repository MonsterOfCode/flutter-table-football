import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/iterable.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';

class GamesProvider {
  /// Request to the API to create a new Team and return it as a model if success
  ///
  /// If fail returns null
  static Future<Game?> create(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return staticGames.last;
  }

  /// Request from the API for a list of Games using a query
  ///
  /// If fail returns null
  static Future<List<Game>> getByQuery({String query = ''}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return staticGames.where((element) => element.searchable.contains(query)).toList();
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
    return await Future.delayed(const Duration(milliseconds: 500)).then((value) => game);
  }

  /// Request to the API to finish the game
  ///
  ///Return the game model to update in UI with the new score and other update on new updates
  ///
  /// If fail returns null
  static Future<Game?> endGame(int gameId) async {
    Game? game = staticGames.firstWhereOrNull((element) => element.id == gameId);
    if (game != null) {
      game = game.copyWith(done: true);
    }
    return await Future.delayed(const Duration(milliseconds: 500)).then((value) => game);
  }
}
