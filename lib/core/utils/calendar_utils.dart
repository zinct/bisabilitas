import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CalendarUtils {
  static String getIndonesianMonth(int month) {
    if (month == 1) {
      return "Jan";
    } else if (month == 2) {
      return "Feb";
    } else if (month == 3) {
      return "Mar";
    } else if (month == 4) {
      return "Apr";
    } else if (month == 5) {
      return "Mei";
    } else if (month == 6) {
      return "Jun";
    } else if (month == 7) {
      return "Jul";
    } else if (month == 8) {
      return "Ags";
    } else if (month == 9) {
      return "Sep";
    } else if (month == 10) {
      return "Okt";
    } else if (month == 11) {
      return "Nov";
    } else if (month == 22) {
      return "Dese";
    } else {
      return "Bulan tidak valid";
    }
  }

  static String getViewFormattedDate(BuildContext context, String? date) {
    final DateFormat viewFormatter = DateFormat('d MMMM yyyy', 'id_ID');
    final DateTime? temp = DateTime.tryParse(date ?? '');
    return viewFormatter.format(temp ?? DateTime.now());
  }

  static String getViewFormattedMonthYear(BuildContext context, String date) {
    final DateFormat viewFormatter = DateFormat('MMMM yyyy', 'id_ID');
    final DateTime temp = DateTime.parse(date);
    return viewFormatter.format(temp);
  }

  static String getViewFormattedHourMinutes(BuildContext context, String date) {
    final DateFormat viewFormatter = DateFormat('HH:mm', 'id_ID');
    final DateTime temp = DateTime.parse(date);
    return viewFormatter.format(temp);
  }

  static String getDefaultDateFormat(DateTime date) {
    final DateFormat viewFormatter = DateFormat('yyyy-MM-dd');
    return viewFormatter.format(date);
  }

  static String getDefaultHourFormat(DateTime date) {
    final DateFormat viewFormatter = DateFormat('HH:mm');
    return viewFormatter.format(date);
  }

  static String getViewDateFormat(BuildContext context, DateTime date) {
    final DateFormat viewFormatter = DateFormat('d MMMM yyyy', 'id_ID');
    return viewFormatter.format(date);
  }

  static String getFullViewFormattedDate(BuildContext context, String date) {
    final DateFormat viewFormatter = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
    final DateTime temp = DateTime.parse(date);
    return viewFormatter.format(temp);
  }

  static String getFullViewFormattedDateTime(
      BuildContext context, String date) {
    final DateFormat viewFormatter =
        DateFormat('EEEE, d MMMM yyyy hh:mm', 'id_ID');
    final DateTime temp = DateTime.parse(date);
    return viewFormatter.format(temp);
  }

  static String getSimpleViewFormattedDate(BuildContext context, String date) {
    final DateFormat viewFormatter = DateFormat('d MMM', 'id_ID');
    final DateTime temp = DateTime.parse(date);
    return viewFormatter.format(temp);
  }

  static String getTimeFromInt(int hour, int minute) {
    var tempHour = '$hour';
    var tempMinute = '$minute';
    if (hour < 10) {
      tempHour = '0$hour';
    }

    if (minute < 10) {
      tempMinute = '0$minute';
    }
    return '$tempHour:$tempMinute';
  }

  static DateTime getDateDefaultFormat(String? date) {
    return DateFormat("yyyy-MM-dd HH:mm")
        .parse(date ?? getDefaultDateFormat(DateTime.now()));
  }
}
