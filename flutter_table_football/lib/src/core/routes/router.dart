import 'package:flutter_table_football/src/core/routes/middlewares/middleware.dart';
import 'package:flutter_table_football/src/data/models/team.model.dart';
import 'package:flutter_table_football/src/views/dashboard/team/create_team.view.dart';
import 'package:flutter_table_football/src/views/dashboard/team/team.view.dart';
import 'package:flutter_table_football/src/views/dashboard/dashboard.view.dart';
import 'package:flutter_table_football/src/views/errors/error.view.dart';
import 'package:flutter_table_football/src/views/welcome.view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  errorBuilder: (context, state) => const ErrorView(),
  initialLocation: "/${WelcomeView.routeName}",
  routes: [
    // Unauthenticated Views
    GoRoute(
      path: "/",
      routes: [
        // Welcome
        GoRoute(name: WelcomeView.routeName, path: WelcomeView.routeName, builder: (context, state) => const WelcomeView()),
      ],
      redirect: AuthenticatedRoutes,
    ),

    // Authenticated Views
    GoRoute(
      path: "/dashboard",
      routes: [
        // Home
        GoRoute(name: DashboardView.routeName, path: DashboardView.routeName, builder: (context, state) => const DashboardView()),
        // Single Team View
        GoRoute(name: TeamView.routeName, path: TeamView.routeName, builder: (context, state) => TeamView(team: state.extra as Team)),
        // Create Team View
        GoRoute(name: CreateTeamView.routeName, path: CreateTeamView.routeName, builder: (context, state) => const CreateTeamView()),
      ],
      redirect: AuthenticatedRoutes,
    ),
  ],
);

// ignore: non_constant_identifier_names
String? UnAuthenticatedRoutes(context, state) {
  return
      // redirect if user is authenticated
      middlewares['unAuthenticated']!.handle(state, context);
}

// ignore: non_constant_identifier_names
String? AuthenticatedRoutes(context, state) {
  return
      // Protect the screen the AuthGuard
      middlewares['authenticated']!.handle(state, context);
}
