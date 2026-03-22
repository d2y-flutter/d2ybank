abstract final class RegexPatterns {
  static final RegExp email = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp phone = RegExp(r'^[0-9]{8,15}$');
  static final RegExp numeric = RegExp(r'^[0-9]+$');
  static final RegExp password = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
}
