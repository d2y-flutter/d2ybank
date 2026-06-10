import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppStartupDestination {
  onboarding,
  home,
  login,
}

abstract final class AppStorageKeys {
  static const hasSeenOnboarding = 'has_seen_onboarding';

  // Sesuaikan key ini nanti kalau backend/auth layer kamu memakai nama berbeda.
  static const accessTokenKeys = [
    'access_token',
    'auth_token',
    'token',
  ];

  static const tokenExpiryKeys = [
    'access_token_expires_at',
    'access_token_expired_at',
    'token_expires_at',
    'token_expired_at',
    'expires_at',
  ];
}

class AppStartupGate {
  AppStartupGate({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  Future<AppStartupDestination> resolveDestination() async {
    final hasSeenOnboarding = await hasCompletedOnboarding();

    if (!hasSeenOnboarding) {
      return AppStartupDestination.onboarding;
    }

    final hasActiveSession = await isSessionActive();

    if (hasActiveSession) {
      return AppStartupDestination.home;
    }

    return AppStartupDestination.login;
  }

  Future<bool> hasCompletedOnboarding() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(AppStorageKeys.hasSeenOnboarding) ?? false;
  }

  Future<void> markOnboardingCompleted() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(AppStorageKeys.hasSeenOnboarding, true);
  }

  Future<bool> isSessionActive() async {
    final token = await _readFirstNonEmpty(AppStorageKeys.accessTokenKeys);

    if (token == null) {
      return false;
    }

    final expired = await _isTokenExpired();

    return !expired;
  }

  Future<bool> _isTokenExpired() async {
    final rawExpiry = await _readFirstNonEmpty(AppStorageKeys.tokenExpiryKeys);

    // Kalau auth layer belum menyimpan expiry, token dianggap aktif selama token ada.
    // Nanti saat backend siap, simpan expiry di salah satu key tokenExpiryKeys.
    if (rawExpiry == null) {
      return false;
    }

    final expiryDate = _parseExpiry(rawExpiry);

    // Kalau format expiry tidak dikenali, jangan paksa logout agar tidak membuat user
    // keluar tiba-tiba. Lebih baik rapikan key/format saat integrasi auth.
    if (expiryDate == null) {
      return false;
    }

    return DateTime.now().toUtc().isAfter(expiryDate.toUtc());
  }

  Future<String?> _readFirstNonEmpty(List<String> keys) async {
    for (final key in keys) {
      final value = await _secureStorage.read(key: key);

      if (value != null && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return null;
  }

  DateTime? _parseExpiry(String rawValue) {
    final trimmedValue = rawValue.trim();

    final numericValue = int.tryParse(trimmedValue);
    if (numericValue != null) {
      final isMilliseconds = numericValue > 1000000000000;

      return isMilliseconds
          ? DateTime.fromMillisecondsSinceEpoch(numericValue, isUtc: true)
          : DateTime.fromMillisecondsSinceEpoch(numericValue * 1000, isUtc: true);
    }

    return DateTime.tryParse(trimmedValue);
  }
}
