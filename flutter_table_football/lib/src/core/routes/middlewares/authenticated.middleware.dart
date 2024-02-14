import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/routes/middlewares/middleware.dart';
import 'package:flutter_table_football/src/views/welcome.view.dart';
import 'package:go_router/go_router.dart';

class AuthenticatedMiddleware implements Middleware {
  @override
  String? handle(GoRouterState state, BuildContext context, {String? routeNameOnError}) {
    // make sure that the user if not authenticated do not continues the navigation
    if (false) {
      // Redirect to the login page
      return routeNameOnError ?? "/${WelcomeView.routeName}";
    }

    // User is authenticated, allow navigation to the next route
    return null;
  }
}
