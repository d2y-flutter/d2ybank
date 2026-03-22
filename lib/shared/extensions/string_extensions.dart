extension StringX on String {
  String get capitalizeFirst => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  String get capitalizeWords => split(' ').map((w) => w.isEmpty ? w : w.capitalizeFirst).join(' ');
  String truncate(int maxLength, {String suffix = '...'}) =>
      length <= maxLength ? this : '${substring(0, maxLength - suffix.length)}$suffix';
  bool get isEmail => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(this);
  bool get isNumeric => double.tryParse(replaceAll(RegExp(r'[^\d.]'), '')) != null;
  String? get nullIfEmpty => isEmpty ? null : this;
  String get initials {
    final parts = trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
