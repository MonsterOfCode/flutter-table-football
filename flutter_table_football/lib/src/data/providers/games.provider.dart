import 'package:dio/dio.dart';
import 'package:flutter_table_football/src/core/services/dio.service.dart';

const basePath = "/games";

class GamesProvider {
  /// Request to the API to create a new Game
  static Future<Response?> create(Map<String, dynamic> data) async => DioService().post(
        "createGame",
        "$basePath/new",
        data: data,
      );

  /// Request from the API for a list of next 10 Games
  static Future<Response?> getLast20() async => DioService().get(
        "getLast20Games",
        "$basePath/last",
      );

  /// Request to the API to add a new goal to a team
  static Future<Response?> updateTeamGoal(int id, Map<String, dynamic> data) async => DioService().put(
        "updateTeamGoal",
        "$basePath/$id",
        data: data,
      );

  /// Request to the API to finish the game
  static Future<Response?> endGame(int id) async => DioService().put(
        "endGame",
        "$basePath/$id",
        data: {"done": true},
      );

  /// Cancel the authenticate request
  static void cancel(String request) async => DioService().cancelRequests(tag: request);
}
