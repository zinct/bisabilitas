import 'package:intl/intl.dart';

class CurrencyUtil {
  static String formatRupiah(dynamic number) {
    final format = NumberFormat.currency(
        locale: 'id_ID', decimalDigits: 0, symbol: 'Rp. ');
    try {
      return format.format(num.parse('$number'));
    } catch (e) {
      return format.format(0);
    }
  }

  static String getNumberSeparator(dynamic number) {
    final format =
        NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: '');
    try {
      return format.format(num.parse('$number'));
    } catch (e) {
      return format.format(0);
    }
  }

  static num getNum(dynamic number) {
    try {
      return num.parse('$number');
    } catch (e) {
      return 0;
    }
  }

  static int getInt(dynamic number) {
    try {
      return int.parse('$number');
    } catch (e) {
      return 0;
    }
  }
}
