import 'package:dio/dio.dart';
import 'package:flutter_table_football/src/core/services/dio.service.dart';

const basePath = "/players";

class PlayersProvider {
  /// Request to the API to create a new Player
  static Future<Response> create(Map<String, dynamic> data) async => DioService().post(
        "authenticate",
        "$basePath/new",
        data: data,
      );

  /// Request from the API for a list of Players using a query
  static Future<Response?> getByQuery({String query = ''}) async => DioService().get(
        "getByQuery",
        "$basePath/search",
        queryParams: {"query": query},
      );

  /// Request to the API check if the nickname is available or not
  static Future<Response?> validateNickname(String nickname) async => DioService().get(
        "validateNickname",
        "$basePath/nickname",
        queryParams: {"name": nickname},
      );

  /// Request to the API by the top 10 playersLite
  static Future<Response?> fetchTop10() async => DioService().get(
        "getTop10",
        "$basePath/top",
      );

  /// Request to the API by the full data of a player
  static Future<Response?> getByName(String nickname) async => DioService().get(
        "loadProfile",
        "$basePath/$nickname",
      );

  /// Cancel the authenticate request
  static void cancel(String request) async => DioService().cancelRequests(tag: request);
}
