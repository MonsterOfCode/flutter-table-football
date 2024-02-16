import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/date_time.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';

class GameListItem extends StatelessWidget {
  final Game game;
  final Team team1;
  final Team team2;
  const GameListItem({super.key, required this.game, required this.team1, required this.team2});

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
                  team1.name.toText,
                  const SizedBox(width: 10),
                  "${game.scoreOfTeam(team1)}".toText,
                ],
              ),
              const Icon(Icons.remove),
              Row(
                children: [
                  "${game.scoreOfTeam(team2)}".toText,
                  const SizedBox(width: 10),
                  team2.name.toText,
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
