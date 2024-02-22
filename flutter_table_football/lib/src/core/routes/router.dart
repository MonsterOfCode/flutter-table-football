import 'package:flutter_table_football/src/data/models/game.model.dart';
import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/views/dashboard/auth.view.dart';
import 'package:flutter_table_football/src/views/dashboard/game/create_game.view.dart';
import 'package:flutter_table_football/src/views/dashboard/game/game.view.dart';
import 'package:flutter_table_football/src/views/dashboard/player/create_player.view.dart';
import 'package:flutter_table_football/src/views/dashboard/player/player.view.dart';
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
      // here is were we can use middlewares
      redirect: (context, state) => null,
    ),

    // Authenticated Views
    GoRoute(
      path: "/dashboard",
      routes: [
        // Home
        GoRoute(name: DashboardView.routeName, path: DashboardView.routeName, builder: (context, state) => const DashboardView()),

        // Single Team View
        GoRoute(name: TeamView.routeName, path: TeamView.routeName, builder: (context, state) => TeamView(team: state.extra)),
        // Create Team View
        GoRoute(name: CreateTeamView.routeName, path: CreateTeamView.routeName, builder: (context, state) => const CreateTeamView()),

        // Single Game View
        GoRoute(name: GameView.routeName, path: GameView.routeName, builder: (context, state) => GameView(game: state.extra as Game)),
        // Create Game View
        GoRoute(name: CreateGameView.routeName, path: CreateGameView.routeName, builder: (context, state) => const CreateGameView()),

        // Single Player View
        GoRoute(name: PlayerView.routeName, path: PlayerView.routeName, builder: (context, state) => PlayerView(player: state.extra)),
        // Create Game View
        GoRoute(
            name: CreatePlayerView.routeName,
            path: CreatePlayerView.routeName,
            builder: (context, state) => CreatePlayerView(
                  isToReturn: state.extra as bool?,
                )),

        // Auth Player View
        GoRoute(name: AuthView.routeName, path: AuthView.routeName, builder: (context, state) => AuthView(player: state.extra as Player)),
      ],
      // here is were we can use middlewares
      redirect: (context, state) => null,
    ),
  ],
);
