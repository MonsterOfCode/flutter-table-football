import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';

class GlassScaffold extends StatelessWidget {
  final Widget? title;
  final Widget? child;
  final String backgroundPath;
  const GlassScaffold({super.key, required this.backgroundPath, this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: title,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glass effect overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          // Content on top of the glass effect
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(kSpacing),
              child: SingleChildScrollView(child: child),
            ),
          ),
        ],
      ),
    );
  }
}
