// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/extensions/widgets/text.extension.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  /// Text styles
  final _Text text = _Text();
  final _Colors colors = _Colors();
  final borders = Borders;
}

@immutable
class _Text {
  TextStyle get title => const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

  TextStyle bigTitle(BuildContext context) => title.copyWith(
        color: Colors.white,
        fontSize: 36.0,
      );

  TextStyle h1(BuildContext context) => context.textTheme.headlineMedium!;

  TextStyle h2(BuildContext context) => context.textTheme.headlineSmall!;

  TextStyle h3(BuildContext context) => context.textTheme.titleLarge!;

  TextStyle h4(BuildContext context) => context.textTheme.titleLarge!.copyWith(fontSize: 20);

  TextStyle h5(BuildContext context) => body(context).copyWith(fontWeight: FontWeight.bold, fontSize: body(context).fontSize! + 2);

  TextStyle body(BuildContext context) => context.textTheme.bodyLarge!;

  TextStyle w800(BuildContext context) => body(context).copyWith(fontWeight: FontWeight.w800);

  TextStyle bold(BuildContext context) => body(context).copyWith(fontWeight: FontWeight.bold);

  TextStyle bigNote(BuildContext context) => context.textTheme.labelLarge!;

  TextStyle note(BuildContext context) => context.textTheme.labelMedium!;

  TextStyle noteStrong(BuildContext context) => context.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold);

  TextStyle smallNote(BuildContext context) => context.textTheme.labelSmall!;

  TextStyle invisible() => const TextStyle(fontSize: 0);

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

@immutable
class Borders {
  static const double btn = s5;

  static const double dialog = 12;

  /// Xs
  static const double s3 = 3;

  static BorderRadius get s3Border => BorderRadius.all(s3Radius);

  static Radius get s3Radius => const Radius.circular(s3);

  /// Small
  static const double s5 = 5;

  static BorderRadius get s5Border => BorderRadius.all(s5Radius);

  static Radius get s5Radius => const Radius.circular(s5);

  /// Medium
  static const double s8 = 8;

  static const BorderRadius s8Border = BorderRadius.all(s8Radius);

  static const Radius s8Radius = Radius.circular(s8);

  /// Large
  static const double s10 = 10;

  static BorderRadius get s10Border => BorderRadius.all(s10Radius);

  static Radius get s10Radius => const Radius.circular(s10);
}
