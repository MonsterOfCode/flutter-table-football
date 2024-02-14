import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/string.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';
import 'package:go_router/go_router.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/welcome/background.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          "UPS!".bigTitle(context),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () => context.go("/"),
            child: "Go back!".h1(context).bold(context).color(Colors.white),
          ),
        ],
      ),
    );
  }
}
