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

class PlayerView extends StatefulWidget {
  final Object? player;
  static const routeName = "player";
  static const routePath = "/dashboard/player";
  const PlayerView({super.key, required this.player});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late Player _player;
  bool _isLoading = false;

  @override
  void initState() {
    assert(widget.player is Player || widget.player is PlayerLite, "You must  pass a valid model of the class Player or PlayerLite");
    if (widget.player is Player) {
      _player = widget.player as Player;
      return;
    }

    _isLoading = true;
    _requestPlayerProfile();
    super.initState();
  }

  @override
  void dispose() {
    PlayersRepository.cancelLoadProfile();
    super.dispose();
  }

  void _requestPlayerProfile() {
    PlayersRepository.loadProfile((widget.player as PlayerLite).name).then((value) {
      if (value == null) {
        context.showErrorSnackBar("Ups! Please try later", type: MessageTypes.error);
        return;
      }
      if (!mounted) return;

      setState(() {
        _player = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: _isLoading ? "Loading..." : _player.name,
      backgroundPath: 'assets/player/background.jpeg',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(kSpacing),
                    child: SizedBox(
                      width: double.infinity,
                      child: StatsTable<Player>(
                        title: "Stats".h1(context).color(context.colorScheme.primary),
                        future: Future.value([_player]),
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
                        future: Future.value(_player.topTeams),
                      ),
                    ),
                  ),
                ),
              ],
            ).scrollable(),
    );
  }
}
