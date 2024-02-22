// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/widget.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/repositories/games.repository.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/glass_scaffold.dart';
import 'package:flutter_table_football/src/widgets/lists/players_simple_list.dart';

class GameView extends StatefulWidget {
  final Game game;
  static const routeName = "game";
  static const routePath = "/dashboard/game";
  const GameView({super.key, required this.game});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late Game _game;
  bool _isLoading = false;
  int? _idTeamUpdating;

  @override
  void initState() {
    _game = widget.game;
    super.initState();
  }

  void _updateTeamGoals(int teamId, int currentGoals, {bool toIncrement = true}) {
    setState(() {
      _isLoading = true;
      _idTeamUpdating = teamId;
    });
    GamesRepository.updateTeamGoal(_game.id, teamId, currentGoals, toIncrement: toIncrement).then((updatedGame) {
      setState(() {
        _game = updatedGame!;
        _isLoading = false;
      });
    });
  }

  void _endGame() {
    context.showConfirmationAlertDialog("Are you sure want to finish the match?").then((response) {
      if (response) {
        GamesRepository.endGame(_game.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: _game.done ? "Finished" : "Running ⏳",
      actions: !_game.done
          ? [
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: _endGame,
                tooltip: 'Show Alert',
              ),
            ]
          : null,
      backgroundPath: 'assets/game/background.jpeg',
      child: Column(
        children: [
          _renderGameInfo(),
          const SizedBox(height: kSpacingExtraLarge),
          PlayersSimpleList(title: "${_game.teamA.name} members", players: _game.teamA.players),
          PlayersSimpleList(title: "${_game.teamB.name} members", players: _game.teamB.players),
        ],
      ).scrollable(),
    );
  }

  // render the Game info section
  Widget _renderGameInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _GameInfoTeamItem(
          team: _game.teamA,
          onPressed: _game.done ? null : _updateTeamGoals,
          isLoading: _isLoading && _idTeamUpdating == _game.teamA.id,
          teamScore: _game.scoreTeamA,
        ),
        _GameMinute(_game),
        _GameInfoTeamItem(
          team: _game.teamB,
          onPressed: _game.done ? null : _updateTeamGoals,
          isLoading: _isLoading && _idTeamUpdating == _game.teamB.id,
          teamScore: _game.scoreTeamB,
        ),
      ],
    );
  }
}

//Widget that renders the minutes of the game automatically
class _GameMinute extends StatelessWidget {
  final Game game;
  const _GameMinute(this.game);

  Text _renderGameMinute() {
    int minute = game.gameMinute();
    return (minute != -1 ? "$minute'" : '').title;
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
          return Column(
            children: [
              "X".bigTitle(context),
              _renderGameMinute(),
            ],
          );
        },
      );
}

// Widget that will render the info for each team
class _GameInfoTeamItem extends StatelessWidget {
  final TeamLite team;
  final bool isLoading;
  final int teamScore;
  final void Function(int, int, {bool toIncrement})? onPressed;

  const _GameInfoTeamItem({
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
        if (onPressed != null)
          IconButton(
            onPressed: () => onPressed!(team.id, teamScore),
            icon: isLoading ? const SizedBox(width: 50, height: 50, child: CircularProgressIndicator.adaptive()) : const Icon(Icons.add, color: Colors.white, size: 50),
          ),
        teamScore.toString().bigTitle(context),
        if (onPressed != null)
          IconButton(
            onPressed: () => onPressed!(team.id, teamScore, toIncrement: false),
            icon: isLoading ? const SizedBox(width: 50, height: 50, child: CircularProgressIndicator.adaptive()) : const Icon(Icons.remove, color: Colors.white, size: 50),
          ),
      ],
    );
  }
}
