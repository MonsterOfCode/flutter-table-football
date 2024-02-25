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
  bool _gameUpdated = false;
  int? _idTeamUpdating;

  @override
  void initState() {
    _game = widget.game;
    super.initState();
  }

  void _updateTeamGoals(int teamId, {bool toIncrement = true}) {
    setState(() {
      _isLoading = true;
      _idTeamUpdating = teamId;
    });
    int action = toIncrement ? 1 : -1;
    Map<String, dynamic> data = {
      "team_a_score": _game.scoreTeamA,
      "team_b_score": _game.scoreTeamB,
      "team_a_action": _game.teamA.id == teamId ? action : 0,
      "team_b_action": _game.teamB.id == teamId ? action : 0,
    };
    GamesRepository.updateTeamGoal(_game.id, data).then((updatedGame) {
      if (!mounted) return;
      if (updatedGame is Game) {
        setState(() {
          _game = updatedGame;
          _isLoading = false;
          _gameUpdated = true;
        });
        return;
      }
      throw Exception("An error occurred while incrementing score in a game.");
    });
  }

  void _endGame() {
    context.showConfirmationAlertDialog("Are you sure want to finish the match?").then((response) {
      if (response) {
        GamesRepository.endGame(_game.id).then((updatedGame) {
          if (!mounted) return;
          if (updatedGame is Game) {
            setState(() {
              _game = updatedGame;
              _isLoading = false;
              _gameUpdated = true;
            });
            return;
          }
          throw Exception("An error occurred while finishing a game.");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: _game.done ? "Finished" : "Running ⏳",
      // to allow return a flag when the list must be updated after changes on game models
      leading: Padding(
        padding: const EdgeInsets.only(left: 11),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(_gameUpdated ? _game : false),
          tooltip: 'Go Back',
        ),
      ),
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
  final void Function(int, {bool toIncrement})? onPressed;

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
        team.name.truncateString(5).bigTitle(context),
        if (onPressed != null)
          IconButton(
            onPressed: () => onPressed!(team.id),
            icon: isLoading ? const SizedBox(width: 50, height: 50, child: CircularProgressIndicator.adaptive()) : const Icon(Icons.add, color: Colors.white, size: 50),
          ),
        teamScore.toString().bigTitle(context),
        if (onPressed != null)
          IconButton(
            onPressed: () => onPressed!(team.id, toIncrement: false),
            icon: isLoading ? const SizedBox(width: 50, height: 50, child: CircularProgressIndicator.adaptive()) : const Icon(Icons.remove, color: Colors.white, size: 50),
          ),
      ],
    );
  }
}
