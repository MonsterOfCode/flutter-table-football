import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/data/repositories/games.repository.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/widgets/future_list.dart';
import 'package:flutter_table_football/src/widgets/list_items/game_item.dart';

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
                  if (team.lastGamesId.isNotEmpty) _TeamInfoSection(team: team),
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
                  _TeamMembersSection(team: team),
                  if (team.lastGamesId.isNotEmpty) _LastGamesSection(team: team),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///Private Widget to render the Team info Section of the View
class _TeamInfoSection extends StatelessWidget {
  const _TeamInfoSection({
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

///Private Widget to render the Team Members Section of the View
class _TeamMembersSection extends StatelessWidget {
  const _TeamMembersSection({
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

///Private Widget to render the Last Games Section of the View
class _LastGamesSection extends StatelessWidget {
  final Team team;

  const _LastGamesSection({
    required this.team,
  });

  /// This function is used to request the data about the other team
  Future<Team?> getOtherTeam(Game game, Team t) async {
    if (game.idTeam1 != t.id) {
      return TeamsRepository.getById(game.idTeam1);
    }
    return TeamsRepository.getById(game.idTeam2);
  }

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
              FutureListWidget<Game>(
                future: GamesRepository.getGamesById(team.lastGamesId),
                renderItem: (game) {
                  // get the Other team data
                  return FutureBuilder<Team?>(
                    future: getOtherTeam(game, team),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive(); // Show loading indicator
                      } else if (snapshot.hasData) {
                        final team2 = snapshot.data!;
                        return GameListItem(game: game, team1: team, team2: team2);
                      } else {
                        return Text('No team data available');
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///Private Widget to render the Team info item of Team info section
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
