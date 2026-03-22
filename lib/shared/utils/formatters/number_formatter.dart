import 'package:intl/intl.dart';

abstract final class NumberFormatter {
  static String thousand(num v) => NumberFormat('#,##0').format(v);
  static String compact(num v) => NumberFormat.compact(locale: 'en_US').format(v);
  static String percentage(double v, {int decimals = 1}) => '${(v * 100).toStringAsFixed(decimals)}%';
}
