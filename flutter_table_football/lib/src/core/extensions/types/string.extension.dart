import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/theme/styles.dart';

extension StringExtension on String {
  String truncateString(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return '${substring(0, maxLength)}...';
    }
  }

  /// Wraps the string in a Text
  Text get toText {
    return Text(this);
  }

  /// Wraps the string in a Text with Title style
  Text get title => Text(this, style: $styles.text.title);

  /// Wraps the string in a Text with Big Title style
  Text bigTitle(context) {
    return Text(
      this,
      style: $styles.text.bigTitle(context),
    );
  }

  /// Wraps the string in a Text with H1
  Text h1(context) {
    return Text(
      this,
      style: $styles.text.h1(context),
    );
  }

  /// Wraps the string in a Text with H2
  Text h2(context) {
    return Text(
      this,
      style: $styles.text.h2(context),
    );
  }

  /// Wraps the string in a Text with H3
  Text h3(context) {
    return Text(
      this,
      style: $styles.text.h3(context),
    );
  }

  /// Wraps the string in a Text with H4
  Text h4(context) {
    return Text(
      this,
      style: $styles.text.h4(context),
    );
  }

  /// Wraps the string in a Text with bodyBold
  Text bodyBold(context) {
    return Text(
      this,
      style: $styles.text.bold(context),
    );
  }

  /// Wraps the string in a Text with bigNote
  Text bigNote(context) {
    return Text(
      this,
      style: $styles.text.bigNote(context),
    );
  }

  /// Wraps the string in a Text with note
  Text note(context) {
    return Text(
      this,
      style: $styles.text.note(context),
    );
  }
}
