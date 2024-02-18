import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/team/create_team.view.dart';
import 'package:flutter_table_football/src/widgets/list_items/team_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/lists/searchable_list.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/list_view_scaffold.dart';
import 'package:go_router/go_router.dart';

class TeamsView extends StatelessWidget {
  const TeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(
      title: 'Teams List',
      floatingButtonTooltip: "Add new team",
      onPressedFloatingButton: () => context.pushNamed(CreateTeamView.routeName),
      child: SearchableList<TeamLite>(
        fetchItems: TeamsRepository.getByQuery,
        renderItem: (element) {
          return TeamSearchableListItem(team: element);
        },
      ),
    );
  }
}
