import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/identity_verification_entity.dart';
import '../repositories/identity_verification_repository.dart';

class SubmitFaceVerificationUseCase {
  final IdentityVerificationRepository repository;

  SubmitFaceVerificationUseCase(this.repository);

  Future<Either<String, IdentityVerificationEntity>> call(
    SubmitFaceVerificationParams params,
  ) {
    return repository.submitFaceVerification(imagePath: params.imagePath);
  }
}

class SubmitFaceVerificationParams extends Equatable {
  final String imagePath;

  const SubmitFaceVerificationParams({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}