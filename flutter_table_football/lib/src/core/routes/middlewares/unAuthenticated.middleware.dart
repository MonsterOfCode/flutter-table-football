import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/routes/middlewares/middleware.dart';
import 'package:flutter_table_football/src/views/dashboard/dashboard.view.dart';
import 'package:go_router/go_router.dart';

class UnauthenticatedMiddleware implements Middleware {
  @override
  String? handle(GoRouterState state, BuildContext context, {String? routeNameOnError}) {
    // make sure that the user if authenticated do not continues the navigation
    if (false) {
      // Redirect to the dashboard page
      // $appService.menuSelectedIndex = $routeDashboardIndex;
      return routeNameOnError ?? "/${DashboardView.routeName}";
    }

    // User is not authenticated, allow navigation to the next route
    return null;
  }
}
