import 'package:flutter/material.dart';
import 'package:flutter_table_football/src/core/theme/styles.dart';

extension StringExtension on String {
  Text get toText {
    return Text(this);
  }

  Text get title => Text(this, style: $styles.text.title);

  Text bigTitle(context) {
    return Text(
      this,
      style: $styles.text.bigTitle(context),
    );
  }

  Text h1(context) {
    return Text(
      this,
      style: $styles.text.h1(context),
    );
  }

  Text h2(context) {
    return Text(
      this,
      style: $styles.text.h2(context),
    );
  }

  Text h3(context) {
    return Text(
      this,
      style: $styles.text.h3(context),
    );
  }

  Text h4(context) {
    return Text(
      this,
      style: $styles.text.h4(context),
    );
  }

  Text h5(context) {
    return Text(
      this,
      style: $styles.text.h5(context),
    );
  }

  Text body(context) {
    return Text(
      this,
      style: $styles.text.body(context),
    );
  }

  Text w800(context) {
    return Text(
      this,
      style: $styles.text.w800(context),
    );
  }

  Text bodyBold(context) {
    return Text(
      this,
      style: $styles.text.bold(context),
    );
  }

  Text bigNote(context) {
    return Text(
      this,
      style: $styles.text.bigNote(context),
    );
  }

  Text note(context) {
    return Text(
      this,
      style: $styles.text.note(context),
    );
  }

  Text noteStrong(context) {
    return Text(
      this,
      style: $styles.text.noteStrong(context),
    );
  }

  Text label(context) {
    return Text(
      this,
      style: $styles.text.bigNote(context),
    );
  }

  Text smallNote(context) {
    return Text(
      this,
      style: $styles.text.smallNote(context),
    );
  }
}
