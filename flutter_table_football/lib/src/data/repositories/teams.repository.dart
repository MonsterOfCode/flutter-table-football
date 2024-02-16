import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/data/providers/teams.provider.dart';

class TeamsRepository {
  /// Request to be created a new Player by a Map
  ///
  /// If something wrong returns null
  static Future<Team?> create(Map<String, dynamic> data) async {
    return TeamsProvider.create(data);
  }

  /// Fetch all the players registered at the platform
  static Future<List<Team>> getAll() async {
    return TeamsProvider.fetch();
  }
}
