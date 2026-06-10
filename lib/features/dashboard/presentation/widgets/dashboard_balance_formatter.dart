abstract final class DashboardBalanceFormatter {
  static String fromAccount(dynamic account) {
    if (account == null) return '0';

    final dynamic rawBalance = _readValue(account, const [
      'balance',
      'availableBalance',
      'currentBalance',
      'totalBalance',
    ]);

    if (rawBalance is num) return _formatNumber(rawBalance);
    if (rawBalance is String && rawBalance.trim().isNotEmpty) {
      return rawBalance.replaceAll('Rp', '').trim();
    }

    // Temporary fallback while BE dashboard API is still in progress.
    return '125.450.000';
  }

  static dynamic _readValue(dynamic source, List<String> fields) {
    for (final field in fields) {
      try {
        switch (field) {
          case 'balance':
            return source.balance;
          case 'availableBalance':
            return source.availableBalance;
          case 'currentBalance':
            return source.currentBalance;
          case 'totalBalance':
            return source.totalBalance;
        }
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  static String _formatNumber(num value) {
    final integer = value.round().toString();
    final buffer = StringBuffer();

    for (int i = 0; i < integer.length; i++) {
      final reverseIndex = integer.length - i;
      buffer.write(integer[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) buffer.write('.');
    }

    return buffer.toString();
  }
}
