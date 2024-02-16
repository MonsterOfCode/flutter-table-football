import 'package:flutter_table_football/src/data/models/game.model.dart';

List<Game> staticGames = [
  Game(id: 1, idTeam1: 1, idTeam2: 2, scoreTeam1: 2, scoreTeam2: 1, dateTime: DateTime.now(), done: true),
  Game(id: 2, idTeam1: 3, idTeam2: 2, scoreTeam1: 4, scoreTeam2: 5, dateTime: DateTime.now(), done: true),
  Game(id: 3, idTeam1: 1, idTeam2: 3, scoreTeam1: 3, scoreTeam2: 6, dateTime: DateTime.now(), done: true),
];

class GamesProvider {
  /// Request to the API to create a new Team and return it as a model if success
  ///
  /// If fail returns null
  static Future<Game?> create(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 2));
    return Game(id: 200, idTeam1: 1, idTeam2: 3, scoreTeam1: 3, scoreTeam2: 6, dateTime: DateTime.now(), done: true);
  }

  /// Request to the API Games By Id
  ///
  /// If fail returns an empty List
  static Future<List<Game>> getByID(List<int> ids) async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) {
      return staticGames.where((element) => ids.contains(element.id)).toList();
    }).catchError((onError) {
      return List<Game>.empty(growable: true);
    });
  }

  /// Request to the API by the list of all Players
  ///
  /// If fail returns an empty List
  static Future<List<Game>> fetch() async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticGames).catchError((onError) {
      return List<Game>.empty(growable: true);
    });
  }
}
