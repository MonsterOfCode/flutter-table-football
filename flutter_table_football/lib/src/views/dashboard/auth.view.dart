import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/widget.extension.dart';
import 'package:flutter_table_football/src/data/models/lite/player_lite.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/widgets/dashboard/stats_table.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/glass_scaffold.dart';

class AuthView extends StatelessWidget {
  final Player player;
  static const routeName = "auth";
  static const routePath = "/dashboard/auth";

  const AuthView({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: player.name,
      backgroundPath: 'assets/player/background.jpeg',
      actions: [
        IconButton(
          icon: const Icon(Icons.logout), // Use user or avatar icon
          onPressed: () {},
        ),
      ],
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(kSpacing),
              child: SizedBox(
                width: double.infinity,
                child: StatsTable<Player>(
                  title: "Stats".h1(context).color(context.colorScheme.primary),
                  future: Future.value([player]),
                ),
              ),
            ),
          ),
          const SizedBox(height: kSpacingExtraLarge),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(kSpacing),
              child: SizedBox(
                width: double.infinity,
                child: StatsTable(
                  title: "Your best Teams".h3(context).color(context.colorScheme.primary),
                  future: TeamsRepository.getTopPlayerTeams(player.name),
                ),
              ),
            ),
          ),
        ],
      ).scrollable(),
    );
  }
}
