import 'package:dartz/dartz.dart';
import 'package:d2ybank/core/constants/storage_keys.dart';
import 'package:d2ybank/core/services/biometric_service.dart';
import 'package:d2ybank/core/services/secure_storage_service.dart';

import '../../domain/entities/biometric_availability_entity.dart';
import '../../domain/entities/biometric_setup_entity.dart';
import '../../domain/repositories/biometric_repository.dart';

class BiometricRepositoryImpl implements BiometricRepository {
  final BiometricService biometricService;
  final SecureStorageService secureStorageService;

  BiometricRepositoryImpl({
    required this.biometricService,
    required this.secureStorageService,
  });

  @override
  Future<Either<String, BiometricAvailabilityEntity>> checkAvailability() async {
    try {
      final isSupported = await biometricService.isDeviceSupported();
      final canCheck = await biometricService.canCheckBiometrics();
      final types = await biometricService.getAvailableBiometrics();

      final label = biometricService.resolveBiometricLabel(types);

      return right(
        BiometricAvailabilityEntity(
          isDeviceSupported: isSupported,
          canCheckBiometrics: canCheck,
          availableTypes: types,
          label: label,
        ),
      );
    } catch (_) {
      return left('Tidak dapat memeriksa biometrik pada perangkat ini.');
    }
  }

  @override
  Future<Either<String, BiometricSetupEntity>> enableBiometric({
    required String userId,
    required String deviceId,
  }) async {
    try {
      final isAvailable = await biometricService.isAvailable();

      if (!isAvailable) {
        return left('Biometrik tidak tersedia pada perangkat ini.');
      }

      final authenticated = await biometricService.authenticate(
        localizedReason:
            'Aktifkan biometrik untuk masuk dan bertransaksi dengan aman.',
      );

      if (!authenticated) {
        return left('Autentikasi biometrik dibatalkan.');
      }

      final registeredAt = DateTime.now();

      await secureStorageService.write(
        key: StorageKeys.biometricEnabled,
        value: 'true',
      );
      await secureStorageService.write(
        key: StorageKeys.biometricUserId,
        value: userId,
      );
      await secureStorageService.write(
        key: StorageKeys.biometricDeviceId,
        value: deviceId,
      );
      await secureStorageService.write(
        key: StorageKeys.biometricRegisteredAt,
        value: registeredAt.toIso8601String(),
      );

      // TODO backend-ready:
      // Kirim userId, deviceId, registeredAt, device model, dan public key/device token
      // ke backend untuk binding biometric login.
      // Backend sebaiknya tidak menerima data biometric mentah.

      return right(
        BiometricSetupEntity(
          isEnabled: true,
          userId: userId,
          deviceId: deviceId,
          registeredAt: registeredAt,
        ),
      );
    } catch (_) {
      return left('Gagal mengaktifkan biometrik. Silakan coba lagi.');
    }
  }

  @override
  Future<Either<String, BiometricSetupEntity>> skipBiometric() async {
    await secureStorageService.write(
      key: StorageKeys.biometricEnabled,
      value: 'false',
    );

    return right(
      const BiometricSetupEntity(
        isEnabled: false,
      ),
    );
  }
}