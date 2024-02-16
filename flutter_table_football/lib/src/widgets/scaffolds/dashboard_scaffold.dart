import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';

class DashboardScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  const DashboardScaffold({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title.title,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: child,
        ),
      ),
    );
  }
}
