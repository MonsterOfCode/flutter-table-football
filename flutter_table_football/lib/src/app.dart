import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/routes/router.dart';
import 'package:flutter_table_football/src/core/services/dio.service.dart';
import 'package:flutter_table_football/src/core/theme/styles.dart';

/// Entry widget to the app
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize DioService singleton instance
    DioService();

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: $styles.colors.colorSeed),
      title: appName,
      builder: (context, child) {
        return Scaffold(
          body: child,
        );
      },
    );
  }
}
