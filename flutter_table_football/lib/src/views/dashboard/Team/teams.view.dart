import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/team_lite.model.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/team/create_team.view.dart';
import 'package:flutter_table_football/src/views/dashboard/team/team.view.dart';
import 'package:flutter_table_football/src/widgets/list_items/default_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/lists/searchable_list.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/list_view_scaffold.dart';
import 'package:go_router/go_router.dart';

/// Screen to show list of teams and search for
///
/// Is stateful to allow cancel request when user leaves the screen
class TeamsView extends StatefulWidget {
  const TeamsView({super.key});

  @override
  State<TeamsView> createState() => _TeamsViewState();
}

class _TeamsViewState extends State<TeamsView> {
  @override
  void dispose() {
    TeamsRepository.cancelGetByQuery();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(
      title: 'Teams ',
      floatingButtonTooltip: "Add new team",
      onPressedFloatingButton: () => context.pushNamed(CreateTeamView.routeName),
      child: SearchableList<TeamLite>(
        fetchItems: TeamsRepository.getByQuery,
        renderItem: (element) {
          return DefaultSearchableListItem<TeamLite>(
            model: element,
            onSelect: (e) {
              context.pushNamed(TeamView.routeName, extra: e);
              return false;
            },
          );
        },
      ),
    );
  }
}
