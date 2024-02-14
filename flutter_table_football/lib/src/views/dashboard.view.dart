import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  static const routeName = "dashboard";
  static const routePath = "/dashboard";

  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Welcome"),
    );
  }
}
