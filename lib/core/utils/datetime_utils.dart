///
/// datetime_utils.dart
/// lib/core/utils
///
/// Created by Indra Mahesa https://github.com/zinct
///

import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(format, {DateTime? dateTime}) {
    final formatter = DateFormat(format, 'id_ID');
    return formatter.format(dateTime ?? DateTime.now());
  }

  static String humanFormat({
    DateTime? dateTime,
    bool showTime = false,
    bool showDayName = true,
  }) {
    DateFormat formatter;

    if (showTime) {
      if (showDayName) {
        formatter = DateFormat('EEEE, d MMMM y HH:mm', 'id_ID');
      } else {
        formatter = DateFormat('d MMMM y HH:mm', 'id_ID');
      }
    } else {
      if (showDayName) {
        formatter = DateFormat('EEEE, d MMMM y', 'id_ID');
      } else {
        formatter = DateFormat('d MMMM y', 'id_ID');
      }
    }

    return formatter.format(dateTime ?? DateTime.now());
  }
}
