import 'package:flutter_table_football/src/core/constants/constants.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get toStringDateOnly {
    // This will format the date as "Year-Month-Day Hour:Minute"
    return DateFormat(formatDateDefault).format(this);
  }

  String get toStringDateTime {
    // This will format the date as "Year-Month-Day Hour:Minute"
    return DateFormat(formatDateTimeDefault).format(this);
  }
}
