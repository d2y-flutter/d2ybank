import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

abstract final class DateFormatter {
  static String standard(DateTime d) => DateFormat('dd MMM yyyy').format(d);
  static String full(DateTime d) => DateFormat('dd MMMM yyyy').format(d);
  static String dateTime(DateTime d) => DateFormat('dd MMM yyyy, HH:mm').format(d);
  static String time24(DateTime d) => DateFormat('HH:mm').format(d);
  static String relative(DateTime d) => timeago.format(d);
  static String smart(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(d.year, d.month, d.day);
    if (dateOnly == today) return 'Today';
    if (dateOnly == today.subtract(const Duration(days: 1))) return 'Yesterday';
    return standard(d);
  }
}
