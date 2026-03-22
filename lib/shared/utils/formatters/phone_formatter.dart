abstract final class PhoneFormatter {
  static String formatLocal(String phone) {
    final d = phone.replaceAll(RegExp(r'\D'), '');
    if (d.length < 4) return d;
    final buf = StringBuffer();
    for (int i = 0; i < d.length; i++) {
      if (i == 4 || i == 8) buf.write('-');
      buf.write(d[i]);
    }
    return buf.toString();
  }
  static String mask(String phone) {
    final d = phone.replaceAll(RegExp(r'\D'), '');
    if (d.length < 8) return phone;
    return '${d.substring(0, d.length - 8)}****${d.substring(d.length - 4)}';
  }
}
