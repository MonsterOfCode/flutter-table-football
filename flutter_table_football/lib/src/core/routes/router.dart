import 'package:flutter_table_football/src/views/dashboard.view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(initialLocation: DashboardView.routePath, routes: [
  // Initial
  GoRoute(name: DashboardView.routeName, path: DashboardView.routePath, builder: (context, state) => const DashboardView()),
]);
