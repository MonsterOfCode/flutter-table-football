import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/utils/form_validations.util.dart';
import 'package:flutter_table_football/src/data/repositories/auth.repository.dart';

/// Widget that allow to create or make the user authentication
///
/// [isToCreate] is the flag if the user is creating or making the login
class PlayerDialog extends StatefulWidget {
  final bool isToCreate;
  const PlayerDialog({super.key, this.isToCreate = false});

  @override
  State<PlayerDialog> createState() => _PlayerDialogState();
}

class _PlayerDialogState extends State<PlayerDialog> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isToCreate = false;

  @override
  void initState() {
    _isToCreate = widget.isToCreate;
    super.initState();
  }

  void _singUp() {
    AuthRepository.signUp(_textController.text.trim().toLowerCase()).then((player) {
      if (player != null) {
        String msg = "Player created successfully!";
        context.showErrorSnackBar(msg, type: MessageTypes.success);
        Navigator.of(context).pop(player);
        return;
      }

      context.showConfirmationAlertDialog("Ups, looks like this nickname is already in use.\nPlease enter other nickname.");
      setState(() {
        _isLoading = false;
        _isToCreate = false;
      });
    });
  }

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
            _isToCreate = true;
            _singUp();
          } else {
            _isLoading = false;
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

      if (_isToCreate) {
        _singUp();
      } else {
        _authenticate();
      }
    }
  }

  void _onCancel() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _isToCreate ? const Text('New Player Nickname') : const Text('Enter you Nickname'),
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
