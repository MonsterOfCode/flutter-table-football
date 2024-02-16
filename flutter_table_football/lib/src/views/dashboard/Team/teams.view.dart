import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/views/dashboard/team/create_team.view.dart';
import 'package:go_router/go_router.dart';

class TeamsView extends StatelessWidget {
  const TeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 'Teams view'.title),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add new team",
        onPressed: () => context.pushNamed(CreateTeamView.routeName),
        backgroundColor: context.colorScheme.primary,
        child: Icon(Icons.add, color: context.colorScheme.background),
      ),
    );
  }
}
