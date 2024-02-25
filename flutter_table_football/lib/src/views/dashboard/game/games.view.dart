import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/repositories/games.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/game/create_game.view.dart';
import 'package:flutter_table_football/src/widgets/list_items/game_searchable_list_item.dart';
import 'package:flutter_table_football/src/widgets/lists/future_list.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/list_view_scaffold.dart';
import 'package:go_router/go_router.dart';

/// Screen to show list of next games
///
/// Is stateful to allow cancel request when user leaves the screen
class GamesView extends StatefulWidget {
  const GamesView({super.key});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  @override
  void dispose() {
    GamesRepository.cancelGetNextGames();
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(
      title: 'Last Games',
      floatingButtonTooltip: "Add new team",
      onPressedFloatingButton: () => context.pushNamed(CreateGameView.routeName),
      child: FutureList(
        fetchItems: GamesRepository.getLast20Games,
        renderItem: (element) {
          return GameListItemWithResult(game: element);
        },
      ),
    );
  }
}
