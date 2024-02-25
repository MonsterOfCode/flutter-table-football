import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/date_time.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/views/dashboard/game/game.view.dart';
import 'package:go_router/go_router.dart';

/// This widget is stateful to update after the model changes on game view and comes back
class GameListItemWithResult extends StatefulWidget {
  final Game game;
  const GameListItemWithResult({super.key, required this.game});

  @override
  State<GameListItemWithResult> createState() => _GameListItemWithResultState();
}

class _GameListItemWithResultState extends State<GameListItemWithResult> {
  Game? game;

  @override
  void initState() {
    game = widget.game;
    super.initState();
  }

  void navigateToGameView(BuildContext context) {
    context.pushNamed(GameView.routeName, extra: game).then((value) {
      // if the user makes changes on game model the list must updates
      if (value is Game) {
        setState(() {
          game = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => navigateToGameView(context),
      title: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  game!.teamA.name.truncateString(10).toText,
                  const Icon(Icons.close),
                  game!.teamB.name.truncateString(10).toText,
                ],
              ),
              const SizedBox(width: kSpacingLarge),
              game!.dateTime.toStringDateTime.note(context),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              "${game!.scoreTeamA}".title,
              ":".title,
              "${game!.scoreTeamB}".title,
              if (!game!.done) "⏳".toText,
            ],
          ),
        ],
      ),
    );
  }
}
