import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/date_time.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';

///  Widget to show the game item in the searchable list
///
/// This widget is stateful to better render optimizations
class GameSearchableListItem extends StatefulWidget {
  final Game game;

  const GameSearchableListItem({
    super.key,
    required this.game,
  });

  @override
  State<GameSearchableListItem> createState() => _GameSearchableListItemState();
}

class _GameSearchableListItemState extends State<GameSearchableListItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isSelected ? const Icon(Icons.local_play) : null,
      title: Row(
        children: [
          Row(
            children: [
              Row(
                children: [
                  widget.game.teamA.name.toText,
                  const Icon(Icons.close),
                  widget.game.teamB.name.toText,
                ],
              ),
              const SizedBox(width: kSpacingLarge),
              widget.game.dateTime.toStringDateTime.note(context),
            ],
          ),
          const Spacer(),
          widget.game.done
              ? "⏳".toText
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    "${widget.game.scoreTeamA}".title,
                    ":".title,
                    "${widget.game.scoreTeamB}".title,
                  ],
                ),
        ],
      ),
      selected: isSelected,
    );
  }
}
