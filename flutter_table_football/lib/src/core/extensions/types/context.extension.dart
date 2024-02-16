import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/enums/message_types.enum.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  void get pop => Navigator.of(this).pop();

  // SnackBar Notifications
  void showErrorSnackBar(String msg, {MessageTypes type = MessageTypes.info}) {
    late Color backgroundColor;
    switch (type) {
      case MessageTypes.success:
        backgroundColor = Colors.green[400]!;
        break;
      case MessageTypes.error:
        backgroundColor = colorScheme.error;
        break;
      default:
        backgroundColor = colorScheme.primary;
    }
    final snackBar = SnackBar(
      content: Center(child: msg.title),
      duration: const Duration(seconds: 2),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
