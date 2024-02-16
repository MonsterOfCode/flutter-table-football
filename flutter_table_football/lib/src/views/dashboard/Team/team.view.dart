import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/widgets/list_items/game_item.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/glass_scaffold.dart';

class TeamView extends StatelessWidget {
  final Team team;
  static const routeName = "team";
  static const routePath = "/dashboard/team";
  const TeamView({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: team.name.toText.color(context.colorScheme.background),
      backgroundPath: 'assets/team/background.jpeg',
      child: Column(
        children: [
          if (team.lastGames.isNotEmpty) _TeamInfoSection(team: team),
          if (team.lastGames.isEmpty)
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
          if (team.lastGames.isNotEmpty) _LastGamesSection(team: team),
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
                    value: "${team.ratio} %",
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: team.lastGames.length,
                itemBuilder: (context, index) {
                  return GameListItem(game: team.lastGames[index]);
                },
              )
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
