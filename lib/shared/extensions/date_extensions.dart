import '../utils/formatters/date_formatter.dart';

extension DateTimeX on DateTime {
  String get formatted => DateFormatter.standard(this);
  String get formattedFull => DateFormatter.full(this);
  String get relative => DateFormatter.relative(this);
  String get smart => DateFormatter.smart(this);
  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;
  bool get isToday => isSameDay(DateTime.now());
}
