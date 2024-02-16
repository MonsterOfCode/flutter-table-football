import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';

///  Widget to show player item in the searchable list
///
/// This widget is stateful to better render optimizations
class TeamSearchableListItem extends StatefulWidget {
  final TeamLite team;

  const TeamSearchableListItem({
    super.key,
    required this.team,
  });

  @override
  State<TeamSearchableListItem> createState() => _TeamSearchableListItemState();
}

class _TeamSearchableListItemState extends State<TeamSearchableListItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isSelected ? const Icon(Icons.local_play) : const SizedBox.shrink(),
      title: Text(widget.team.name),
      selected: isSelected,
    );
  }
}
