import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  //
  Widget scrollable({Axis scrollDirection = Axis.vertical, ScrollController? controller}) {
    return SingleChildScrollView(controller: controller, scrollDirection: scrollDirection, child: this);
  }
}
