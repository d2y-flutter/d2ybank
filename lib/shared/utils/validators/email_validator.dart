abstract final class EmailValidator {
  static bool isValid(String email) => RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email.trim());
  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!isValid(value)) return 'Enter a valid email address';
    return null;
  }
}
