import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/data/providers/teams.provider.dart';

class TeamsRepository {
  /// Request to be created a new Player by a Map
  ///
  /// If something wrong returns null
  static Future<Team?> create(Map<String, dynamic> data) async {
    return TeamsProvider.create(data);
  }

  /// Fetch a team
  static Future<Team?> getById(int id) async {
    return TeamsProvider.getById(id);
  }

  /// Fetch all the teams registered at the platform
  static Future<List<Team>> getAll() async {
    return TeamsProvider.fetch();
  }
}
