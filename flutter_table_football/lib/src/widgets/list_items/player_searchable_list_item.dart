import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';

class PlayerSearchableListItem extends StatefulWidget {
  final Player player;

  const PlayerSearchableListItem({
    super.key,
    required this.player,
  });

  @override
  State<PlayerSearchableListItem> createState() => _PlayerSearchableListItemState();
}

class _PlayerSearchableListItemState extends State<PlayerSearchableListItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isSelected ? const Icon(Icons.local_play) : const SizedBox.shrink(),
      title: Text(widget.player.name),
      trailing: Text("${widget.player.points} pts"),
      selected: isSelected,
    );
  }
}
