abstract final class ApiEndpoints {
  static const auth = _Auth();
  static const user = _User();
}

class _Auth {
  const _Auth();
  String get login => '/auth/login';
  String get register => '/auth/register';
  String get logout => '/auth/logout';
  String get refresh => '/auth/refresh';
  String get verifyOtp => '/auth/verify-otp';
}

class _User {
  const _User();
  String get profile => '/user/profile';
  String get updateProfile => '/user/profile';
}
