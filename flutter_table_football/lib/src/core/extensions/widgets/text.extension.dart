import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';
import 'package:flutter_table_football/src/core/theme/styles.dart';

extension TextExtension on Text {
  Text color(Color? color) {
    return Text(data!, style: style != null ? style!.copyWith(color: color) : TextStyle(color: color));
  }

  Text primary(BuildContext context) {
    Color primary = context.colorScheme.primary;
    return Text(data!, style: style != null ? style!.copyWith(color: primary, fontWeight: FontWeight.bold) : $styles.text.bold(context).copyWith(color: primary));
  }

  Text primaryBold(BuildContext context) {
    Color primary = context.colorScheme.primary;
    return Text(data!, style: style != null ? style!.copyWith(color: primary) : TextStyle(color: primary));
  }

  Text get center {
    return Text(data!, style: style, textAlign: TextAlign.center);
  }

  Text invertColor(BuildContext context) {
    return Text(data!, style: style != null ? style!.copyWith(color: context.colorScheme.background) : TextStyle(color: context.colorScheme.background));
  }

  Text bold(context) {
    return Text(data!, style: style != null ? style!.copyWith(fontWeight: FontWeight.bold) : $styles.text.bold(context));
  }

  SelectableText selectable() {
    return SelectableText(data!, style: style);
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle newColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle bold() {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle w800() {
    return copyWith(fontWeight: FontWeight.w800);
  }
}
