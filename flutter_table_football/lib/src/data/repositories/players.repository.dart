import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/providers/players.provider.dart';

class PlayersRepository {
  /// Request to be created a new Player by a Map
  ///
  /// If something wrong returns null
  static Future<dynamic> create(Map<String, dynamic> data) async {
    try {
      final response = await PlayersProvider.create(data);
      if (response != null && response.statusCode == 201) {
        return Player.fromMap(response.data);
      }
      return {'error': 'Unknown error', 'response': response};
    } catch (error, stackTrace) {
      debugPrint("Error on creating player $error \n$stackTrace");
      return {'error': 'Unknown error', 'details': error.toString()};
    }
  }

  /// Request the full data of a player
  ///
  /// If something wrong or player do not exist returns null
  static Future<Player?> loadProfile(String nickname) async {
    try {
      final response = await PlayersProvider.getByName(nickname);
      if (response != null && response.statusCode == 200) {
        return Player.fromMap(response.data["data"]);
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

  static void cancelLoadProfile() => PlayersProvider.cancel("getByName");

  /// Fetch the teams registered on the platform
  ///
  /// If fail returns null
  static Future<List<PlayerLite>> getByQuery({String query = ''}) async {
    try {
      final List<PlayerLite> list = List.empty(growable: true);

      final response = await PlayersProvider.getByQuery(query: query);

      if (response != null && response.statusCode == 200) {
        for (var element in response.data["data"]) {
          list.add(PlayerLite.fromMap(element));
        }
        return list;
      }
      return [];
    } catch (error, stackTrace) {
      debugPrint("Error on getByQuery $error \n$stackTrace");
      return [];
    }
  }

  static void cancelGetByQuery() => PlayersProvider.cancel("getByQueryPlayer");

  /// Check if a nickname is available
  ///
  /// [true] the nickname is available
  /// if not available it will return the error Map
  static Future<dynamic> validateNickname(String nickname) async {
    try {
      final response = await PlayersProvider.validateNickname(nickname);
      if (response != null && response.statusCode == 200) {
        return true;
      }
      return {'error': 'Unknown error', 'response': response};
    } on DioException catch (error) {
      if (error.response?.statusCode == 422) {
        return error.response?.data;
      }
    } catch (error, stackTrace) {
      debugPrint("Error on validateNickname $error \n$stackTrace");
      return {'error': 'Unknown error', 'details': error.toString()};
    }
  }

  /// Fetch the top 10 players
  ///
  /// If fail returns an empty List
  static Future<List<Player>> getTop10() async {
    try {
      final List<Player> list = List.empty(growable: true);
      final response = await PlayersProvider.fetchTop10();
      if (response != null && response.statusCode == 200) {
        for (var element in response.data["data"]) {
          list.add(Player.fromMap(element));
        }
        return list;
      }
      return [];
    } catch (error, stackTrace) {
      debugPrint("Error on getTop10 $error \n$stackTrace");
      return [];
    }
  }

  static void cancelGetTop10() => PlayersProvider.cancel("getTop10Player");
}
