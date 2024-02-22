import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/iterable.extension.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';

class TeamsProvider {
  /// Request to the API to create a new Team and return it as a model if success
  ///
  /// If fail returns null
  static Future<Team?> create(Map<String, dynamic> data) async {
    // TODO Connect to the real API
    await Future.delayed(const Duration(milliseconds: 500));
    return staticTeams.last;
  }

  /// Request to the API by the full data of a Team
  ///
  /// If fail returns null
  static Future<Team?> getById(int id) async {
    // TODO Connect to the real API
    await Future.delayed(const Duration(milliseconds: 500));
    return staticTeams.firstWhereOrNull((element) => element.id == id);
  }

  /// Request from the API for a list of Teams using a query
  ///
  /// If fail returns null
  static Future<List<TeamLite>> getByQuery({String query = ''}) async {
    // TODO Connect to the real API
    await Future.delayed(const Duration(milliseconds: 500));
    return staticTeamsLite.where((element) => element.searchable.contains(query)).toList();
  }

  /// Request to the API by the top 10 teams
  ///
  /// If fail returns an empty List
  static Future<List<Team>> fetchTop10() async {
    // TODO Connect to the real API
    return await Future.delayed(const Duration(milliseconds: 500)).then((value) => staticTeams).catchError((onError) {
      return List<Team>.empty(growable: true);
    });
  }

  /// Request to the API by the top [nOfTeams] teams of a player
  ///
  /// If fail returns an empty List
  static Future<List<Team>> fetchTopPlayerTeams(String playerName, int nOfTeams) async {
    // TODO Connect to the real API
    return await Future.delayed(const Duration(milliseconds: 500)).then((value) => staticTeams).catchError((onError) {
      return List<Team>.empty(growable: true);
    });
  }
}
