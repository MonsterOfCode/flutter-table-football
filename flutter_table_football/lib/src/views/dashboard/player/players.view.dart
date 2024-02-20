import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/player/create_player.view.dart';
import 'package:flutter_table_football/src/widgets/list_items/default_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/lists/searchable_list.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/list_view_scaffold.dart';
import 'package:go_router/go_router.dart';

class PlayersView extends StatelessWidget {
  const PlayersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(
      title: 'Players',
      floatingButtonTooltip: "Add new player",
      onPressedFloatingButton: () => context.pushNamed(CreatePlayerView.routeName),
      child: SearchableList<PlayerLite>(
        fetchItems: PlayersRepository.getByQuery,
        renderItem: (element) {
          return DefaultSearchableListItem<PlayerLite>(model: element);
        },
      ),
    );
  }
}
