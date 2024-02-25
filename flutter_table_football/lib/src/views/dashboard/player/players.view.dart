import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/player/create_player.view.dart';
import 'package:flutter_table_football/src/views/dashboard/player/player.view.dart';
import 'package:flutter_table_football/src/widgets/list_items/default_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/lists/searchable_list.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/list_view_scaffold.dart';
import 'package:go_router/go_router.dart';

/// Screen to show list of players and search for
///
/// Is stateful to allow cancel request when user leaves the screen
class PlayersView extends StatefulWidget {
  const PlayersView({super.key});

  @override
  State<PlayersView> createState() => _PlayersViewState();
}

class _PlayersViewState extends State<PlayersView> {
  @override
  void dispose() {
    PlayersRepository.cancelGetByQuery();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(
      title: 'Players',
      floatingButtonTooltip: "Add new player",
      onPressedFloatingButton: () => context.pushNamed(CreatePlayerView.routeName),
      child: SearchableList<PlayerLite>(
        fetchItems: PlayersRepository.getByQuery,
        renderItem: (element) {
          return DefaultSearchableListItem<PlayerLite>(
            model: element,
            onSelect: (e) {
              context.pushNamed(PlayerView.routeName, extra: e);
              return false;
            },
          );
        },
      ),
    );
  }
}
