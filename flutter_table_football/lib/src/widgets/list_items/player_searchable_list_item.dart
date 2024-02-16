import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';

///  Widget to show player item in the searchable list
///
/// This widget is stateful to better render optimizations
class PlayerSearchableListItem extends StatefulWidget {
  final PlayerLite player;

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
