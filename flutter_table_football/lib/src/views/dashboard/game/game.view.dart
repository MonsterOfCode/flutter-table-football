import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/widgets/scaffolds/glass_scaffold.dart';

class GameView extends StatelessWidget {
  final Team team;
  static const routeName = "game";
  static const routePath = "/dashboard/game";
  const GameView({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return const GlassScaffold(backgroundPath: 'assets/game/background.jpeg');
  }
}
