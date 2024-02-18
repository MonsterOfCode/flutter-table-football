import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';

class ListViewScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final void Function()? onPressedFloatingButton;
  final String? floatingButtonTooltip;
  final IconData? floatingButtonIcon;
  const ListViewScaffold({super.key, required this.title, required this.child, this.onPressedFloatingButton, this.floatingButtonTooltip, this.floatingButtonIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title.title,
      ),
      body: child,
      floatingActionButton: FloatingActionButton(
        tooltip: floatingButtonTooltip,
        onPressed: onPressedFloatingButton,
        backgroundColor: context.colorScheme.primary,
        child: Icon(floatingButtonIcon ?? Icons.add, color: context.colorScheme.background),
      ),
    );
  }
}
