import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Convert a DateTime to String Date only
  ///
  /// This will format the date as "Day-Month-Year"
  String get toStringDateOnly {
    return DateFormat(formatDateDefault).format(this);
  }

  /// Convert a DateTime to String DateTime
  ///
  /// This will format the date as "Day-Month-Year Hour:Minute"
  String get toStringDateTime {
    return DateFormat(formatDateTimeDefault).format(this);
  }
}
