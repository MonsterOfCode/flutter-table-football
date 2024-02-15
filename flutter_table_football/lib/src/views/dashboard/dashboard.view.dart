import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/views/dashboard/games.view.dart';
import 'package:flutter_table_football/src/views/dashboard/home.view.dart';
import 'package:flutter_table_football/src/views/dashboard/player.view.dart';
import 'package:flutter_table_football/src/views/dashboard/Team/teams.view.dart';

class DashboardView extends StatefulWidget {
  static const routeName = "dashboard";
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int currentPageIndex = 0;

  List<NavigationDestination> navigationDestinations = dashboardMenuItems.entries.map((entry) {
    return NavigationDestination(
      selectedIcon: Icon(entry.value.$2),
      icon: Icon(entry.value.$2),
      label: entry.value.$1,
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: context.colorScheme.secondary,
        selectedIndex: currentPageIndex,
        destinations: navigationDestinations,
      ),
      body: <Widget>[
        /// Home page
        const HomeView(),
        const TeamsView(),
        const GamesView(),
        const PlayerView(),
      ][currentPageIndex],
    );
  }
}
