import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/biometric_setup_entity.dart';
import '../repositories/biometric_repository.dart';

class EnableBiometricUseCase {
  final BiometricRepository repository;

  EnableBiometricUseCase(this.repository);

  Future<Either<String, BiometricSetupEntity>> call(
    EnableBiometricParams params,
  ) {
    return repository.enableBiometric(
      userId: params.userId,
      deviceId: params.deviceId,
    );
  }
}

class EnableBiometricParams extends Equatable {
  final String userId;
  final String deviceId;

  const EnableBiometricParams({
    required this.userId,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [userId, deviceId];
}