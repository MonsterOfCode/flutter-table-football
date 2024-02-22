import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/utils/form_validations.util.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/repositories/auth.repository.dart';
import 'package:flutter_table_football/src/views/dashboard/player/create_player.view.dart';
import 'package:go_router/go_router.dart';

/// Widget that allow to create or make the user authentication
///
/// [isToCreate] is the flag if the user is creating or making the login
class PlayerDialog extends StatefulWidget {
  const PlayerDialog({super.key});

  @override
  State<PlayerDialog> createState() => _PlayerDialogState();
}

class _PlayerDialogState extends State<PlayerDialog> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _authenticate() {
    AuthRepository.authenticate(_textController.text.trim().toLowerCase()).then((player) async {
      if (player != null) {
        String msg = "Player Authenticated successfully!";
        context.showErrorSnackBar(msg, type: MessageTypes.success);
        Navigator.of(context).pop(player);
        return;
      }

      context.showConfirmationAlertDialog("No Player founded with this nickname \nDo you want to create a new one?").then((value) {
        setState(() {
          // is the value is true is because the user wants to create a user
          if (value) {
            _onCancel();
            // we call the create view passing the extra true to is not navigates to the
            // Player view and instead comes back to dashboard
            context.pushNamed(CreatePlayerView.routeName, extra: true);
          }
        });
      });
    });
  }

  void _onConfirm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      _authenticate();
    }
  }

  void _onCancel() => Navigator.of(context).pop();

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
        TextButton(onPressed: _onCancel, child: const Text('Cancel')),
        _isLoading ? const CircularProgressIndicator.adaptive() : TextButton(onPressed: _onConfirm, child: const Text('Confirm')),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
