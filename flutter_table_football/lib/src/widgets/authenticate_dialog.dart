import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/data/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/utils/form_validations.util.dart';
import 'package:flutter_table_football/src/data/repositories/auth.repository.dart';

class AuthenticateDialog extends StatefulWidget {
  const AuthenticateDialog({super.key});

  @override
  State<AuthenticateDialog> createState() => _AuthenticateDialogState();
}

class _AuthenticateDialogState extends State<AuthenticateDialog> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isToCreate = false;

  void _authenticate() {
    AuthRepository.authenticate(_textController.text.trim().toLowerCase(), _isToCreate).then((player) async {
      if (player != null) {
        String msg = "Player ${_isToCreate ? "created" : "Authenticated"} successfully!";
        context.showErrorSnackBar(msg, type: MessageTypes.success);
        Navigator.of(context).pop(player);
        return;
      }

      context.showConfirmationAlertDialog("No Player founded with this nickname \n Do you want to create a new one?").then((value) {
        if (value) {
          setState(() {
            _isToCreate = true;
          });
          _authenticate();
          return;
        }
        _onCancel();
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
