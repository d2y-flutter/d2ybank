abstract final class PasswordValidator {
  static const int minLength = 8;
  static bool isStrong(String p) => p.length >= minLength && p.contains(RegExp(r'[A-Z]')) && p.contains(RegExp(r'[a-z]')) && p.contains(RegExp(r'[0-9]'));
  static String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < minLength) return 'Minimum $minLength characters';
    if (!value.contains(RegExp(r'[A-Z]'))) return 'Must contain uppercase letter';
    if (!value.contains(RegExp(r'[0-9]'))) return 'Must contain a number';
    return null;
  }
}
