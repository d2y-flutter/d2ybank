import '../utils/formatters/currency_formatter.dart';

extension NumX on num {
  String toIdr({bool showSymbol = true}) => CurrencyFormatter.idr(this, showSymbol: showSymbol);
  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
}
