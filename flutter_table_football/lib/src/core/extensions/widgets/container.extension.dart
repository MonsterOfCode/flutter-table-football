import 'package:flutter/widgets.dart';
import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:flutter_table_football/src/core/extensions/types/context.extension.dart';

extension SizedBoxExtension on SizedBox {
  /// Replaces a SizedBox with a container with the layout to be a bottom sheet
  Container toBottomSheet(BuildContext context, {EdgeInsetsGeometry? margin}) {
    return Container(
      key: key,
      width: width,
      height: height,
      margin: margin,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(kBorderRadiusLarge),
          topLeft: Radius.circular(kBorderRadiusLarge),
        ),
      ),
      child: child,
    );
  }
}
