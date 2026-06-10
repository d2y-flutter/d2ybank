import 'package:dartz/dartz.dart';

import '../entities/biometric_setup_entity.dart';
import '../repositories/biometric_repository.dart';

class SkipBiometricUseCase {
  final BiometricRepository repository;

  SkipBiometricUseCase(this.repository);

  Future<Either<String, BiometricSetupEntity>> call() {
    return repository.skipBiometric();
  }
}