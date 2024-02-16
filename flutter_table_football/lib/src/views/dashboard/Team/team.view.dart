import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';

List<Game> staticGames = [
  Game(idTeam1: 1, idTeam2: 2, scoreTeam1: 2, scoreTeam2: 1, dateTime: DateTime.now(), done: true),
  Game(idTeam1: 1, idTeam2: 2, scoreTeam1: 2, scoreTeam2: 1, dateTime: DateTime.now(), done: true),
  Game(idTeam1: 1, idTeam2: 2, scoreTeam1: 2, scoreTeam2: 1, dateTime: DateTime.now(), done: true),
];

class TeamView extends StatelessWidget {
  final Team team;
  static const routeName = "team";
  static const routePath = "/dashboard/team";
  const TeamView({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: team.name.toText.color(context.colorScheme.background),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/team/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glass effect overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          // Content on top of the glass effect
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(kSpacing),
              child: Column(
                children: [
                  if (team.lastGamesId.isNotEmpty) _TeamInfo(team: team),
                  if (team.lastGamesId.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(kSpacing),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: "No games yet".h3(context),
                          ),
                        ),
                      ),
                    ),
                  _TeamMembers(team: team),
                  if (team.lastGamesId.isNotEmpty) _LastGames(team: team),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LastGames extends StatelessWidget {
  const _LastGames({
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Last Games".h3(context),
              Column(
                children: team.players.map((item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      item.name.toText,
                      "${item.points} pts".toText,
                    ],
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamMembers extends StatelessWidget {
  const _TeamMembers({
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Team members".h3(context),
              Column(
                children: team.players.map((item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      item.name.toText,
                      "${item.points} pts".toText,
                    ],
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamInfo extends StatelessWidget {
  const _TeamInfo({
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TeamInfoItem(
                    title: "Points",
                    value: "${team.points}",
                  ),
                  _TeamInfoItem(
                    title: "Games",
                    value: "${team.matches}",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TeamInfoItem(
                    title: "Win",
                    value: "${team.ration} %",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TeamInfoItem(
                    title: "GF ⚽️",
                    value: "${team.goalsFor}",
                  ),
                  _TeamInfoItem(
                    title: "GA ⚽️",
                    value: "${team.goalsAgainst}",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TeamInfoItem extends StatelessWidget {
  final String title;
  final String value;
  const _TeamInfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title.h3(context),
        value.bodyBold(context),
      ],
    );
  }
}
