import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/routes/middlewares/authenticated.middleware.dart';
import 'package:flutter_table_football/src/core/routes/middlewares/unAuthenticated.middleware.dart';
import 'package:go_router/go_router.dart';

// Base class wth the function to make the override withe the verifications if the user can change to the route selected
abstract class Middleware {
  String? handle(GoRouterState state, BuildContext context, {String? routeNameOnError});
}

// Here is where you must put all the Middlewares to be used on the routes
Map<String, Middleware> middlewares = {
  'authenticated': AuthenticatedMiddleware(),
  'unAuthenticated': UnauthenticatedMiddleware(),
};
