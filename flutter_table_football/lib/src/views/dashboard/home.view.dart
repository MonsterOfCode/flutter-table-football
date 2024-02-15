import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/views/dashboard/Team/create_team.view.dart';
import 'package:flutter_table_football/src/widgets/bottom_draggable_container.widget.dart';
import 'package:flutter_table_football/src/widgets/list_items/player_searchable_list_item.dart';
import 'package:go_router/go_router.dart';

List<Player> players = [
  const Player(name: "Player 1", points: 150),
  const Player(name: "Player 2", points: 15),
  const Player(name: "Player 3", points: 10),
  const Player(name: "Player 4", points: 9),
  const Player(name: "Player 5", points: 6),
  const Player(name: "Player 6", points: 5),
];

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        'Home view'.title,
        TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return BottomDraggableScrollableContainer<Player>(
                    title: "Title",
                    elements: players,
                    renderItem: (element) {
                      final player = element;
                      return PlayerSearchableListItem(player: player);
                    },
                  );
                });
          },
          child: "SearchableList".h1(context),
        ),
      ],
    );
  }
}
