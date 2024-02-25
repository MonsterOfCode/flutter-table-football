import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/data/providers/teams.provider.dart';

class TeamsRepository {
  /// Request to be created a new Team by a Map
  ///
  /// If something wrong returns null
  static Future<dynamic> create(Map<String, dynamic> data) async {
    try {
      final response = await TeamsProvider.create(data);
      if (response != null && response.statusCode == 201) {
        return Team.fromMap(response.data);
      }
      return {'error': 'Unknown error', 'response': response};
    } catch (error, stackTrace) {
      debugPrint("Error on creating team $error \n$stackTrace");
      return {'error': 'Unknown error', 'details': error.toString()};
    }
  }

  /// Request the full data of a Team
  ///
  /// If something wrong returns null
  static Future<Team?> getById(int id) async {
    try {
      final response = await TeamsProvider.getById(id);
      if (response != null && response.statusCode == 200) {
        return Team.fromMap(response.data["data"]);
      }
      debugPrint("Error on loading player $response");
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        debugPrint("Player not found");
      }
    } catch (error, stackTrace) {
      debugPrint("Error on loading player $error \n$stackTrace");
    }
    return null;
  }

  static void cancelLoadTeam() => TeamsProvider.cancel("getByIdTeam");

  /// Get teams and allow search by
  ///
  /// If fail returns null
  static Future<List<TeamLite>> getByQuery({String query = ''}) async {
    try {
      final List<TeamLite> list = List.empty(growable: true);

      final response = await TeamsProvider.getByQuery(query: query);

      if (response != null && response.statusCode == 200) {
        for (var element in response.data["data"]) {
          list.add(TeamLite.fromMap(element));
        }
        return list;
      }
      return [];
    } catch (error, stackTrace) {
      debugPrint("Error on getByQuery $error \n$stackTrace");
      return [];
    }
  }

  static void cancelGetByQuery() => TeamsProvider.cancel("getByQueryTeams");

  /// Fetch the top 10 Teams
  ///
  /// If fail returns an empty List
  static Future<List<Team>> getTop10() async {
    try {
      final List<Team> list = List.empty(growable: true);
      final response = await TeamsProvider.fetchTop10();
      if (response != null && response.statusCode == 200) {
        for (var element in response.data["data"]) {
          list.add(Team.fromMap(element));
        }
        return list;
      }
      return [];
    } catch (error, stackTrace) {
      debugPrint("Error on getTop10 $error \n$stackTrace");
      return [];
    }
  }

  static void cancelGetTop10() => TeamsProvider.cancel("getTop10Teams");
}
