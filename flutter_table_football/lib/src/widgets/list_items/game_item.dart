import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/date_time.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';

class GameListItem extends StatelessWidget {
  final Game game;
  const GameListItem({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  game.teamA.name.truncateString(10).toText,
                  const SizedBox(width: 10),
                  "${game.scoreTeamA}".toText,
                ],
              ),
              const Icon(Icons.remove),
              Row(
                children: [
                  "${game.scoreTeamB}".toText,
                  const SizedBox(width: 10),
                  game.teamB.name.truncateString(10).toText,
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              game.dateTime.toStringDateTime.note(context),
              const SizedBox(width: 10),
              (game.done ? "done" : "running").note(context),
            ],
          )
        ],
      ),
    );
  }
}
