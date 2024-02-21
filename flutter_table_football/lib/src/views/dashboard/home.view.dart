import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/widget.extension.dart';
import 'package:flutter_table_football/src/core/utils/form_validations.util.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/repositories/auth.repository.dart';
import 'package:flutter_table_football/src/data/repositories/players.repository.dart';
import 'package:flutter_table_football/src/data/repositories/teams.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/auth.view.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/dashboard_scaffold.dart';
import 'package:flutter_table_football/src/widgets/dashboard/stats_table.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Player? player;
  bool isLoading = true;

  @override
  void initState() {
    loadPlayer();
    super.initState();
  }

  void loadPlayer() async {
    setState(() {
      isLoading = true;
    });
    await AuthRepository.get().then((value) {
      if (!mounted) return;
      setState(() {
        player = value;
        isLoading = false;
      });
    });
  }

  void callbackDialog(Player? player) {
    if (player != null) {
      setState(() {
        player = player;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      title: "Dashboard",
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle), // Use user or avatar icon
          onPressed: () {
            if (player != null) {
              context.pushNamed(AuthView.routeName, extra: player);
              return;
            }
            showDialog(
              context: context,
              builder: (BuildContext context) => AuthenticateDialog(callback: callbackDialog),
            );
          },
        ),
      ],
      child: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (player != null) ...[
                  StatsTable<Player>(
                    title: "My Stats".h1(context).color(context.colorScheme.primary),
                    future: Future.value([player!]),
                  ),
                  const SizedBox(height: kSpacingExtraLarge),
                  StatsTable(
                    title: "My best Teams".h3(context).color(context.colorScheme.primary),
                    future: TeamsRepository.getTopPlayerTeams(player!.name),
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

class AuthenticateDialog extends StatefulWidget {
  final void Function(Player? p) callback;
  const AuthenticateDialog({super.key, required this.callback});

  @override
  State<AuthenticateDialog> createState() => _AuthenticateDialogState();
}

class _AuthenticateDialogState extends State<AuthenticateDialog> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isToCreate = false;

  void authenticate() {
    AuthRepository.authenticate(_textController.text.trim().toLowerCase(), _isToCreate).then((player) async {
      if (player != null) {
        String msg = "Player ${_isToCreate ? "created" : "Authenticated"} successfully!";
        context.showErrorSnackBar(msg, type: MessageTypes.success);
        Navigator.of(context).pop();
        return;
      }

      context.showConfirmationAlertDialog("No Player founded with this nickname \n Do you want to create a new one?").then((value) {
        if (value) {
          setState(() {
            _isToCreate = true;
          });
          authenticate();
          return;
        }
        onCancel();
      });
    });
  }

  void onConfirm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      authenticate();
    }
  }

  void onCancel() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter you Nickname'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          validator: (value) => FormValidations.notEmpty(value, msg: "The nickname is required"),
          controller: _textController,
          keyboardType: TextInputType.text,
        ),
      ),
      actions: <Widget>[
        TextButton(onPressed: onCancel, child: const Text('Cancel')),
        _isLoading ? const CircularProgressIndicator.adaptive() : TextButton(onPressed: onConfirm, child: const Text('Confirm')),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
