import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/iterable.extension.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';

class TeamsProvider {
  /// Request to the API to create a new Team and return it as a model if success
  ///
  /// If fail returns null
  static Future<Team?> create(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 2));
    return staticTeams.last;
  }

  /// Request from the API a Team
  ///
  /// If fail returns null
  static Future<Team?> getById(int id) async {
    await Future.delayed(const Duration(seconds: 2));
    return staticTeams.firstWhereOrNull((element) => element.id == id);
  }

  /// Request to the API by the list of all TeamsLite
  ///
  /// If fail returns an empty List
  static Future<List<TeamLite>> fetch() async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticTeamsLite).catchError((onError) {
      return List<TeamLite>.empty(growable: true);
    });
  }

  /// Request to the API by the top 10 teams
  ///
  /// If fail returns an empty List
  static Future<List<Team>> fetchTop10() async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticTeams).catchError((onError) {
      return List<Team>.empty(growable: true);
    });
  }

  /// Request to the API by the top [nOfTeams] teams of a player
  ///
  /// If fail returns an empty List
  static Future<List<Team>> fetchTopPlayerTeams(String playerName, int nOfTeams) async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticTeams).catchError((onError) {
      return List<Team>.empty(growable: true);
    });
  }
}
