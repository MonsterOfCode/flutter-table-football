library constants;

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';

part 'app.constants.dart';
part 'metrics.constants.dart';
part 'formats.constants.dart';

Map<String, dynamic> staticApiErrorResponse = {
  "message": "Nickname unavailable, please try another one.",
  "errors": {
    "name": ["Nickname unavailable, please try another one."]
  },
};

List<PlayerLite> staticPlayersLite = [
  const PlayerLite(name: "Player 1", points: 150),
  const PlayerLite(name: "Player 2", points: 120),
  const PlayerLite(name: "Player 3", points: 100),
  const PlayerLite(name: "Player 4", points: 80),
  const PlayerLite(name: "Player 5", points: 60),
  const PlayerLite(name: "Player 6", points: 40),
  const PlayerLite(name: "Player 7", points: 30),
  const PlayerLite(name: "Player 8", points: 25),
];

List<Player> staticPlayers = [
  Player(name: staticPlayersLite[0].name, points: staticPlayersLite[0].points, goalsFor: 30, goalsAgainst: 10, wins: 5, losses: 1, ties: 0),
  Player(name: staticPlayersLite[1].name, points: staticPlayersLite[1].points, goalsFor: 25, goalsAgainst: 15, wins: 4, losses: 2, ties: 1),
  Player(name: staticPlayersLite[2].name, points: staticPlayersLite[2].points, goalsFor: 20, goalsAgainst: 20, wins: 3, losses: 3, ties: 2),
  Player(name: staticPlayersLite[3].name, points: staticPlayersLite[3].points, goalsFor: 15, goalsAgainst: 25, wins: 2, losses: 4, ties: 1),
  Player(name: staticPlayersLite[4].name, points: staticPlayersLite[4].points, goalsFor: 10, goalsAgainst: 30, wins: 1, losses: 5, ties: 0),
  Player(name: staticPlayersLite[5].name, points: staticPlayersLite[5].points, goalsFor: 5, goalsAgainst: 35, wins: 0, losses: 6, ties: 0),
  Player(name: staticPlayersLite[6].name, points: staticPlayersLite[6].points, goalsFor: 8, goalsAgainst: 40, wins: 0, losses: 7, ties: 0),
  Player(name: staticPlayersLite[7].name, points: staticPlayersLite[7].points, goalsFor: 7, goalsAgainst: 45, wins: 0, losses: 8, ties: 0),
];

List<Game> staticGames = [
  Game(id: 1, teamA: staticTeamsLite[0], teamB: staticTeamsLite[1], scoreTeamA: 2, scoreTeamB: 1, dateTime: DateTime.now(), done: false),
  Game(id: 2, teamA: staticTeamsLite[1], teamB: staticTeamsLite[2], scoreTeamA: 1, scoreTeamB: 3, dateTime: DateTime.now(), done: false),
  Game(id: 3, teamA: staticTeamsLite[0], teamB: staticTeamsLite[2], scoreTeamA: 4, scoreTeamB: 0, dateTime: DateTime.now(), done: false),
  Game(id: 4, teamA: staticTeamsLite[2], teamB: staticTeamsLite[3], scoreTeamA: 3, scoreTeamB: 2, dateTime: DateTime.now(), done: false),
  Game(id: 5, teamA: staticTeamsLite[1], teamB: staticTeamsLite[3], scoreTeamA: 2, scoreTeamB: 2, dateTime: DateTime.now(), done: false),
];

List<TeamLite> staticTeamsLite = [
  TeamLite(id: 1, name: "Team1", players: [staticPlayersLite[0], staticPlayersLite[1]]),
  TeamLite(id: 2, name: "Team2", players: [staticPlayersLite[2], staticPlayersLite[3]]),
  TeamLite(id: 3, name: "Team3", players: [staticPlayersLite[4], staticPlayersLite[5]]),
  TeamLite(id: 4, name: "Team4", players: [staticPlayersLite[6], staticPlayersLite[7]]),
];

List<Team> staticTeams = [
  Team(id: staticTeamsLite[0].id, name: staticTeamsLite[0].name, players: [staticPlayersLite[0], staticPlayersLite[1]], lastGames: [staticGames[0]]),
  Team(id: staticTeamsLite[1].id, name: staticTeamsLite[1].name, players: [staticPlayersLite[2], staticPlayersLite[3]], lastGames: [staticGames[1]]),
  Team(id: staticTeamsLite[2].id, name: staticTeamsLite[2].name, players: [staticPlayersLite[4], staticPlayersLite[5]], lastGames: [staticGames[2]]),
  Team(id: staticTeamsLite[3].id, name: staticTeamsLite[3].name, players: [staticPlayersLite[6], staticPlayersLite[7]], lastGames: [staticGames[3], staticGames[4]]),
];
