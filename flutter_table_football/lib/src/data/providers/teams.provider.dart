import 'package:dio/dio.dart';
import 'package:flutter_table_football/src/core/services/dio.service.dart';

const basePath = "/teams";

class TeamsProvider {
  /// Request to the API to create a new Team
  static Future<Response?> create(Map<String, dynamic> data) async => DioService().post(
        "createPlayer",
        "$basePath/new",
        data: data,
      );

  /// Request to the API by the full data of a Team
  static Future<Response?> getById(int id) async => DioService().get(
        "getByIdTeam",
        "$basePath/$id",
      );

  /// Request from the API for a list of Teams using a query
  static Future<Response?> getByQuery({String query = ''}) async => DioService().get(
        "getByQueryTeams",
        "$basePath/search",
        queryParams: {"query": query},
      );

  /// Request to the API by the top 10 teams
  static Future<Response?> fetchTop10() async => DioService().get(
        "getTop10Teams",
        "$basePath/top",
      );

  /// Cancel the authenticate request
  static void cancel(String request) async => DioService().cancelRequests(tag: request);
}
