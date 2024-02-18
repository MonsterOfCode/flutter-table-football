import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/repositories/games.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/game/create_game.view.dart';
import 'package:flutter_table_football/src/widgets/list_items/game_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/list_items/team_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/lists/searchable_list.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/list_view_scaffold.dart';
import 'package:go_router/go_router.dart';

class GamesView extends StatelessWidget {
  const GamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(
      title: 'Games List',
      floatingButtonTooltip: "Add new team",
      onPressedFloatingButton: () => context.pushNamed(CreateGameView.routeName),
      child: SearchableList<Game>(
        fetchItems: GamesRepository.getByQuery,
        renderItem: (element) {
          return GameSearchableListItem(game: element);
        },
      ),
    );
  }
}
