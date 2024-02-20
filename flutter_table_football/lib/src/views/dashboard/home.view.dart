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
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle), // Use user or avatar icon
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AuthenticateDialog();
              },
            );
          },
        ),
      ],
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
            ).scrollable(),
    );
  }
}

class AuthenticateDialog extends StatefulWidget {
  const AuthenticateDialog({super.key});

  @override
  State<AuthenticateDialog> createState() => _AuthenticateDialogState();
}

class _AuthenticateDialogState extends State<AuthenticateDialog> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter you Nickname'),
      content: TextField(
        controller: _textController,
      ),
      actions: <Widget>[
        _isLoading
            ? const CircularProgressIndicator.adaptive()
            : ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  // Simulate an asynchronous operation
                  await Future.delayed(Duration(seconds: 2));
                  // Get the text input value
                  String text = _textController.text;
                  // Perform actions with the text
                  print('Entered text: $text');
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              ),
        ElevatedButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
