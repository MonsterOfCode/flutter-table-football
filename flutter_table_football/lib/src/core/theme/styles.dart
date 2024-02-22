// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  /// Text styles
  final _Text text = _Text();
  final _Colors colors = _Colors();
}

@immutable
class _Text {
  TextStyle get title => const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

  TextStyle bigTitle(BuildContext context) => title.copyWith(color: Colors.white, fontSize: 36.0);

  TextStyle h1(BuildContext context) => context.textTheme.headlineMedium!;

  TextStyle h2(BuildContext context) => context.textTheme.headlineSmall!;

  TextStyle h3(BuildContext context) => context.textTheme.titleLarge!;

  TextStyle h4(BuildContext context) => context.textTheme.titleLarge!.copyWith(fontSize: 20);

  TextStyle body(BuildContext context) => context.textTheme.bodyLarge!;

  TextStyle bold(BuildContext context) => body(context).copyWith(fontWeight: FontWeight.bold);

  TextStyle bigNote(BuildContext context) => context.textTheme.labelLarge!;

  TextStyle note(BuildContext context) => context.textTheme.labelMedium!;

  // late final TextStyle h11 = copy(titleFont, sizePx: 64, heightPx: 62);
  TextStyle copy(TextStyle style, {required double sizePx, double? heightPx, double? spacingPc, FontWeight? weight}) {
    return style.copyWith(fontSize: sizePx, height: heightPx != null ? (heightPx / sizePx) : style.height, letterSpacing: spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing, fontWeight: weight);
  }
}

@immutable
class _Colors {
  final Color colorSeed = Colors.blue;
  final warning = const Color(0xFFFFA000);
  final error = const Color(0xFFFF4500);
  final success = const Color(0xFF28a745);
}
