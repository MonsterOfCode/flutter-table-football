import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/widget.extension.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/repositories/auth.repository.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/auth.view.dart';
import 'package:flutter_table_football/src/widgets/authenticate_dialog.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/dashboard_scaffold.dart';
import 'package:flutter_table_football/src/widgets/dashboard/stats_table.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Player? _player;
  bool _isLoading = true;

  @override
  void initState() {
    loadPlayer();
    super.initState();
  }

  @override
  void dispose() {
    PlayersRepository.cancelGetTop10();
    super.dispose();
  }

  void loadPlayer() async {
    setState(() {
      _isLoading = true;
    });
    await AuthRepository.get().then((value) {
      if (!mounted) return;
      setState(() {
        _player = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      title: "Dashboard",
      actions: [
        IconButton(
          icon: Icon(_player != null ? Icons.account_circle : Icons.login), // Use user or avatar icon
          onPressed: () {
            if (_player != null) {
              context.pushNamed(AuthView.routeName, extra: _player).then((value) {
                // if the view returns the value == true
                // it means that the user request the logout
                if (value == true) {
                  setState(() {
                    _player = null;
                  });
                }
              });
              return;
            }
            showDialog(
              context: context,
              builder: (BuildContext context) => const PlayerDialog(),
            ).then((value) {
              // if the dialog returns the value as Player
              // it means that the user makes login successfully
              if (value is Player) {
                setState(() {
                  _player = value;
                });
              }
            });
          },
        ),
      ],
      child: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_player != null) ...[
                  StatsTable<Player>(
                    title: "My Stats".h1(context).color(context.colorScheme.primary),
                    future: Future.value([_player!]),
                  ),
                  const SizedBox(height: kSpacingExtraLarge),
                  StatsTable(
                    title: "My best Teams".h3(context).color(context.colorScheme.primary),
                    future: TeamsRepository.getTopPlayerTeams(_player!.name),
                  ),
                  const SizedBox(height: kSpacingLarge)
                ],
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
            ).scrollable(),
    );
  }
}
