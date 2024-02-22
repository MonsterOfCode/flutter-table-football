// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';

/// Scaffold that makes the glass effect on top of a image
class GlassScaffold extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? child;
  final String backgroundPath;

  const GlassScaffold({
    Key? key,
    this.title,
    this.child,
    required this.backgroundPath,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: title?.title.color(Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: actions,
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
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
