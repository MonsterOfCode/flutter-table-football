import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/widget.extension.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/widgets/list_items/game_item.dart';
import 'package:flutter_table_football/src/widgets/lists/players_simple_list.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/glass_scaffold.dart';

class TeamView extends StatefulWidget {
  final Object? team;
  static const routeName = "team";
  static const routePath = "/dashboard/team";
  const TeamView({super.key, required this.team});

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  late Team _team;
  bool _isLoading = false;

  @override
  void initState() {
    assert(widget.team is Team || widget.team is TeamLite, "You must pass a valid model of the class Team or TeamLite");
    if (widget.team is Team) {
      _team = widget.team as Team;
    } else {
      _isLoading = true;
      _requestTeamProfile();
    }

    super.initState();
  }

  void _requestTeamProfile() {
    TeamsRepository.loadProfile((widget.team as TeamLite).id).then((value) {
      if (value == null) {
        context.showErrorSnackBar("Ups! Please try later", type: MessageTypes.error);
        return;
      }
      setState(() {
        _team = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: _isLoading ? "Loading..." : _team.name,
      backgroundPath: 'assets/team/background.jpeg',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Column(
              children: [
                if (_team.lastGames.isNotEmpty) _TeamInfoSection(team: _team),
                if (_team.lastGames.isEmpty)
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
                PlayersSimpleList(title: "Team members", players: _team.players),
                if (_team.lastGames.isNotEmpty) _LastGamesSection(team: _team),
              ],
            ).scrollable(),
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
