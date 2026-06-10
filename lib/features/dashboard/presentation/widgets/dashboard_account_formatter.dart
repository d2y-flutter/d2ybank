abstract final class DashboardAccountFormatter {
  static String displayName(dynamic account) {
    if (account == null) return 'Aditya';

    final dynamic rawName = _readValue(account, const [
      'name',
      'accountName',
      'holderName',
      'customerName',
      'username',
    ]);

    if (rawName is String && rawName.trim().isNotEmpty) {
      return rawName.trim().split(' ').first;
    }

    return 'Aditya';
  }

  static String? profileImageUrl(dynamic account) {
    if (account == null) return null;

    final dynamic rawUrl = _readValue(account, const [
      'profileImageUrl',
      'avatarUrl',
      'photoUrl',
    ]);

    if (rawUrl is String && rawUrl.trim().isNotEmpty) return rawUrl.trim();
    return null;
  }

  static dynamic _readValue(dynamic source, List<String> fields) {
    for (final field in fields) {
      try {
        switch (field) {
          case 'name':
            return source.name;
          case 'accountName':
            return source.accountName;
          case 'holderName':
            return source.holderName;
          case 'customerName':
            return source.customerName;
          case 'username':
            return source.username;
          case 'profileImageUrl':
            return source.profileImageUrl;
          case 'avatarUrl':
            return source.avatarUrl;
          case 'photoUrl':
            return source.photoUrl;
        }
      } catch (_) {
        continue;
      }
    }
    return null;
  }
}
