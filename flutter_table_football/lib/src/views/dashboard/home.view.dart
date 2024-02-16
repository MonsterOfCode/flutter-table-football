import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/repositories/auth.repository.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/dashboard_scaffold.dart';
import 'package:flutter_table_football/src/widgets/dashboard/stats_table.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Player player;
  bool isLoading = true;

  @override
  void initState() {
    loadPlayer();
    super.initState();
  }

  void loadPlayer() async {
    await AuthRepository.get().then((value) {
      if (!mounted) return;
      setState(() {
        player = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      title: "Dashboard",
      child: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatsTable(
                  title: "My Stats".h1(context).color(context.colorScheme.primary),
                  future: Future.value([player]),
                ),
                const SizedBox(height: kSpacingExtraLarge),
                StatsTable(
                  title: "My best Teams".h3(context).color(context.colorScheme.primary),
                  future: TeamsRepository.getTopPlayerTeams(player.name),
                ),
                const SizedBox(height: kSpacingLarge),
                StatsTable(
                  title: "Top 10 Players".h3(context).color(context.colorScheme.primary),
                  future: PlayersRepository.getTop10(),
                ),
                const SizedBox(height: kSpacingLarge),
                StatsTable(
                  title: "Top 10 Teams".h3(context).color(context.colorScheme.primary),
                  future: TeamsRepository.getTop10(),
                ),
              ],
            ),
    );
  }
}
