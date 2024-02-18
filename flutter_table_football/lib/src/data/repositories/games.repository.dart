import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/providers/games.provider.dart';

class GamesRepository {
  /// Request to be created a new Game by a Map
  ///
  /// If something wrong returns null
  static Future<Game?> create(Map<String, dynamic> data) async {
    return GamesProvider.create(data);
  }

  /// Fetch the teams registered on the platform
  static Future<List<Game>> getByQuery({String query = ''}) async {
    return GamesProvider.getByQuery(query: query);
  }

  /// Add a new Goal to a team
  static Future<Game?> updateTeamGoal(int gameId, int teamId, int currentScore, {bool toIncrement = true}) async {
    return GamesProvider.updateTeamGoal(gameId, teamId, currentScore, toIncrement: toIncrement);
  }

  /// end a Game
  static Future<Game?> endGame(int gameId) async {
    return GamesProvider.endGame(gameId);
  }
}
