import 'package:flutter_table_football/src/core/extensions/types/iterable.extension.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';

List<Team> staticTeams = [
  Team(
    id: 1,
    name: "Team1",
    players: List.from([
      const Player(name: "Team1 p1"),
      const Player(name: "Team1 p2"),
    ]),
  ),
  Team(
    id: 2,
    name: "Team2",
    players: List.from([
      const Player(name: "Team2 p1"),
      const Player(name: "Team2 p2"),
    ]),
  ),
];

class TeamsProvider {
  /// Request to the API to create a new Team and return it as a model if success
  ///
  /// If fail returns null
  static Future<Team?> create(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 2));
    return Team(
      id: 1,
      name: "NewTeam",
      players: List.from([
        const Player(name: "NewTeam p1"),
        const Player(name: "NewTeam p2"),
      ]),
      lastGamesId: const <int>[1, 2, 3],
    );
  }

  /// Request from the API a Team
  ///
  /// If fail returns null
  static Future<Team?> getById(int id) async {
    await Future.delayed(const Duration(seconds: 2));
    return staticTeams.firstWhereOrNull((element) => element.id == id);
  }

  /// Request to the API by the list of all Players
  ///
  /// If fail returns an empty List
  static Future<List<Team>> fetch() async {
    return await Future.delayed(const Duration(seconds: 2)).then((value) => staticTeams).catchError((onError) {
      return List<Team>.empty(growable: true);
    });
  }
}
