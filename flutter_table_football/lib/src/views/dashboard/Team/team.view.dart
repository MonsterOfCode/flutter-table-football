import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';

class TeamView extends StatelessWidget {
  final Team team;
  static const routeName = "team";
  static const routePath = "/dashboard/team";
  const TeamView({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Team view"),
      ),
      body: Center(child: '${team.name}'.title),
    );
  }
}
