abstract final class AppDuration {
  static const Duration fastest = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration slower = Duration(milliseconds: 600);
  static const Duration buttonPress = fast;
  static const Duration pageTransition = medium;
  static const Duration bottomSheet = medium;
  static const Duration toast = Duration(seconds: 3);
  static const Duration snackbar = Duration(seconds: 4);
  static const Duration shimmerCycle = Duration(milliseconds: 1500);
  static const Duration debounceSearch = Duration(milliseconds: 500);
}
