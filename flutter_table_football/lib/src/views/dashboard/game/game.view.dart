// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/repositories/games.repository.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/glass_scaffold.dart';

class GameView extends StatefulWidget {
  final Game game;
  static const routeName = "game";
  static const routePath = "/dashboard/game";
  const GameView({super.key, required this.game});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late Game game;
  bool isLoading = false;
  int? idTeamUpdating;

  @override
  void initState() {
    game = widget.game;
    super.initState();
  }

  void updateTeamGoals(int teamId, int currentGoals, {bool toIncrement = true}) {
    setState(() {
      isLoading = true;
      idTeamUpdating = teamId;
    });
    GamesRepository.updateTeamGoal(game.id, teamId, currentGoals, toIncrement: toIncrement).then((updatedGame) {
      setState(() {
        game = updatedGame!;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      backgroundPath: 'assets/game/background.jpeg',
      child: Column(
        children: [
          _renderGameInfo(),
          const SizedBox(height: kSpacingExtraLarge),
        ],
      ),
    );
  }

  Widget _renderGameInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GameInfoTeamItem(
          team: game.teamA,
          onPressed: updateTeamGoals,
          isLoading: isLoading && idTeamUpdating == game.teamA.id,
          teamScore: game.scoreTeamA,
        ),
        Column(
          children: [
            "X".bigTitle(context),
            _renderGameMinute(),
          ],
        ),
        GameInfoTeamItem(
          team: game.teamB,
          onPressed: updateTeamGoals,
          isLoading: isLoading && idTeamUpdating == game.teamB.id,
          teamScore: game.scoreTeamB,
        ),
      ],
    );
  }

  Text _renderGameMinute() {
    int minute = game.gameMinute();
    return (minute != -1 ? "$minute'" : '').title;
  }
}

class GameInfoTeamItem extends StatelessWidget {
  final TeamLite team;
  final bool isLoading;
  final int teamScore;
  final void Function(int, int, {bool toIncrement})? onPressed;
  const GameInfoTeamItem({
    Key? key,
    required this.team,
    required this.isLoading,
    required this.teamScore,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        team.name.bigTitle(context),
        IconButton(
          onPressed: () => onPressed?.call(team.id, teamScore),
          icon: isLoading ? const SizedBox(width: 50, height: 50, child: CircularProgressIndicator.adaptive()) : const Icon(Icons.add, color: Colors.white, size: 50),
        ),
        teamScore.toString().bigTitle(context),
        IconButton(
          onPressed: () => onPressed?.call(team.id, teamScore, toIncrement: false),
          icon: isLoading ? const SizedBox(width: 50, height: 50, child: CircularProgressIndicator.adaptive()) : const Icon(Icons.remove, color: Colors.white, size: 50),
        ),
      ],
    );
  }
}
