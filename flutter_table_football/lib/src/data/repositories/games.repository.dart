import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/providers/games.provider.dart';

class GamesRepository {
  /// Request to be created a new Game by a Map
  ///
  /// If something wrong returns null
  static Future<dynamic> create(Map<String, dynamic> data) async {
    try {
      final response = await GamesProvider.create(data);
      if (response != null && response.statusCode == 201) {
        return Game.fromMap(response.data);
      }
      return {'error': 'Unknown error', 'response': response};
    } catch (error, stackTrace) {
      debugPrint("Error on creating player $error \n$stackTrace");
      return {'error': 'Unknown error', 'details': error.toString()};
    }
  }

  /// Fetch the next games registered on the platform
  ///
  /// If fail returns null
  static Future<List<Game>> getLast20Games({String query = ''}) async {
    try {
      final List<Game> list = List.empty(growable: true);
      final response = await GamesProvider.getLast20();
      if (response != null && response.statusCode == 200) {
        for (var element in response.data["data"]) {
          list.add(Game.fromMap(element));
        }
        return list;
      }
      return [];
    } catch (error, stackTrace) {
      debugPrint("Error on getNextGames $error \n$stackTrace");
      return [];
    }
  }

  static void cancelGetNextGames() => GamesProvider.cancel("getLast20Games");

  /// Add a new Goal to a team
  ///
  ///Return the game model to update in UI with the new score and other update on new updates
  ///
  ///We sent the current score to prevent multiple increments when called
  ///on diferente devices for the same goal and team
  ///
  /// If fail returns null
  static Future<dynamic> updateTeamGoal(int id, Map<String, dynamic> data) async {
    try {
      final response = await GamesProvider.updateTeamGoal(id, data);
      if (response != null && response.statusCode == 200) {
        return Game.fromMap(response.data["data"]);
      }
      return {'error': 'Unknown error', 'response': response};
    } catch (error, stackTrace) {
      debugPrint("Error on creating player $error \n$stackTrace");
      return {'error': 'Unknown error', 'details': error.toString()};
    }
  }

  /// Request to the API to finish the game
  ///
  ///Return the game model to update in UI with data
  ///
  /// If fail returns null
  static Future<dynamic> endGame(int id) async {
    try {
      final response = await GamesProvider.endGame(id);
      if (response != null && response.statusCode == 200) {
        return Game.fromMap(response.data["data"]);
      }
      return {'error': 'Unknown error', 'response': response};
    } catch (error, stackTrace) {
      debugPrint("Error on creating player $error \n$stackTrace");
      return {'error': 'Unknown error', 'details': error.toString()};
    }
  }
}
