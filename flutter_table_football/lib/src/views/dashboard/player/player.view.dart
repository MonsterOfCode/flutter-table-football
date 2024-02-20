import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/widgets/dashboard/stats_table.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/glass_scaffold.dart';

class PlayerView extends StatelessWidget {
  final Player player;
  static const routeName = "player";
  static const routePath = "/dashboard/player";
  const PlayerView({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: player.name,
      backgroundPath: 'assets/player/background.jpeg',
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(kSpacing),
              child: SizedBox(
                width: double.infinity,
                child: StatsTable(
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
      ),
    );
  }
}
