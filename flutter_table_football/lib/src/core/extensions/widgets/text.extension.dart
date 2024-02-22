import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/theme/styles.dart';

extension TextExtension on Text {
  /// replaces the current Text to other with the new color
  Text color(Color? color) {
    return Text(data!, style: style != null ? style!.copyWith(color: color) : TextStyle(color: color));
  }

  /// replaces the current Text to other with the fontWeight bold
  Text bold(context) {
    return Text(data!, style: style != null ? style!.copyWith(fontWeight: FontWeight.bold) : $styles.text.bold(context));
  }
}

extension TextStyleExtension on TextStyle {
  /// allow to change the color
  TextStyle newColor(Color color) {
    return copyWith(color: color);
  }

  /// Changes the fontWeight to bold
  TextStyle bold() {
    return copyWith(fontWeight: FontWeight.bold);
  }

  /// Changes the fontWeight to w800
  TextStyle w800() {
    return copyWith(fontWeight: FontWeight.w800);
  }
}
