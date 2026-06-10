import 'package:dartz/dartz.dart';

import '../entities/biometric_availability_entity.dart';
import '../entities/biometric_setup_entity.dart';

abstract class BiometricRepository {
  Future<Either<String, BiometricAvailabilityEntity>> checkAvailability();

  Future<Either<String, BiometricSetupEntity>> enableBiometric({
    required String userId,
    required String deviceId,
  });

  Future<Either<String, BiometricSetupEntity>> skipBiometric();
}