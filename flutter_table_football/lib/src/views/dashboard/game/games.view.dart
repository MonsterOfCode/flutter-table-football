import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';

class GamesView extends StatelessWidget {
  const GamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 'Games view'.title),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new game",
        onPressed: () {},
        backgroundColor: context.colorScheme.primary,
        child: Icon(Icons.add, color: context.colorScheme.background),
      ),
    );
  }
}