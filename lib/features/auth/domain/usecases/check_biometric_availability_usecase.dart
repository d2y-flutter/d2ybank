import 'package:dartz/dartz.dart';

import '../entities/biometric_availability_entity.dart';
import '../repositories/biometric_repository.dart';

class CheckBiometricAvailabilityUseCase {
  final BiometricRepository repository;

  CheckBiometricAvailabilityUseCase(this.repository);

  Future<Either<String, BiometricAvailabilityEntity>> call() {
    return repository.checkAvailability();
  }
}