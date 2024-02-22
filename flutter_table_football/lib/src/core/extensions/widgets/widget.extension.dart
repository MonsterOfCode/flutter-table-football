import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  /// Wraps a widget in a SingleChildScrollView to allow it to be scrollable if necessary.
  Widget scrollable({Axis scrollDirection = Axis.vertical, ScrollController? controller}) {
    return SingleChildScrollView(controller: controller, scrollDirection: scrollDirection, child: this);
  }
}
