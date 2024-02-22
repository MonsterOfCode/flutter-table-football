import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/data/providers/teams.provider.dart';

class TeamsRepository {
  /// Request to be created a new Player by a Map
  ///
  /// If something wrong returns null
  static Future<Team?> create(Map<String, dynamic> data) async {
    return TeamsProvider.create(data);
  }

  /// Request the full data of a Team
  ///
  /// If something wrong returns null
  static Future<Team?> getById(int id) async {
    return TeamsProvider.getById(id);
  }

  /// Fetch all the teams registered at the platform
  static Future<List<TeamLite>> getByQuery({String query = ''}) async {
    return TeamsProvider.getByQuery(query: query);
  }

  /// Fetch the top 10 Teams
  static Future<List<Team>> getTop10() async {
    return TeamsProvider.fetchTop10();
  }

  /// Fetch the top teams of a player
  static Future<List<Team>> getTopPlayerTeams(String playerName, {int nOfTeams = 3}) async {
    return TeamsProvider.fetchTopPlayerTeams(playerName, nOfTeams);
  }
}
