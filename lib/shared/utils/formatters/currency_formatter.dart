import 'package:intl/intl.dart';

abstract final class CurrencyFormatter {
  static String idr(num amount, {bool showSymbol = true}) {
    final f = NumberFormat('#,##0', 'id_ID').format(amount);
    return showSymbol ? 'Rp $f' : f;
  }
  static String compact(num amount) => NumberFormat.compact(locale: 'en_US').format(amount);
  static num? parse(String formatted) {
    try {
      final cleaned = formatted.replaceAll(RegExp(r'[^\d,.]'), '').replaceAll('.', '').replaceAll(',', '.');
      return num.tryParse(cleaned);
    } catch (_) { return null; }
  }
}
