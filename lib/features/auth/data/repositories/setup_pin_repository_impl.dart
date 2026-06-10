import 'package:dartz/dartz.dart';
import 'package:d2ybank/core/constants/storage_keys.dart';
import 'package:d2ybank/core/security/pin_hash_service.dart';
import 'package:d2ybank/core/services/secure_storage_service.dart';

import '../../domain/entities/setup_pin_entity.dart';
import '../../domain/repositories/setup_pin_repository.dart';

class SetupPinRepositoryImpl implements SetupPinRepository {
  final SecureStorageService secureStorageService;
  final PinHashService pinHashService;

  SetupPinRepositoryImpl({
    required this.secureStorageService,
    required this.pinHashService,
  });

  @override
  Future<Either<String, SetupPinEntity>> setupPin({
    required String pin,
  }) async {
    try {
      if (!RegExp(r'^\d{6}$').hasMatch(pin)) {
        return left('PIN harus terdiri dari 6 angka.');
      }

      final hashResult = pinHashService.hashPin(pin);
      final createdAt = DateTime.now();

      await secureStorageService.write(
        key: StorageKeys.pinHash,
        value: hashResult.hash,
      );
      await secureStorageService.write(
        key: StorageKeys.pinSalt,
        value: hashResult.salt,
      );
      await secureStorageService.write(
        key: StorageKeys.pinIterations,
        value: hashResult.iterations.toString(),
      );
      await secureStorageService.write(
        key: StorageKeys.pinCreatedAt,
        value: createdAt.toIso8601String(),
      );

      // Backend-ready:
      // Nanti jangan kirim PIN mentah ke backend.
      // Pilihan aman: backend membuat challenge/session, app mengirim proof/token,
      // atau backend menyimpan server-side credential yang sudah di-hash ulang.
      // Untuk saat ini, hash lokal disimpan di secure storage.

      return right(
        SetupPinEntity(
          isCreated: true,
          createdAt: createdAt,
        ),
      );
    } catch (_) {
      return left('Gagal membuat PIN. Silakan coba lagi.');
    }
  }
}