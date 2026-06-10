import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../entities/identity_verification_entity.dart';
import '../repositories/identity_verification_repository.dart';

class SubmitKtpPhotoUseCase {
  final IdentityVerificationRepository repository;

  SubmitKtpPhotoUseCase(this.repository);

  Future<Either<String, IdentityVerificationEntity>> call(
    SubmitKtpPhotoParams params,
  ) {
    return repository.submitKtpPhoto(imagePath: params.imagePath);
  }
}

class SubmitKtpPhotoParams extends Equatable {
  final String imagePath;

  const SubmitKtpPhotoParams({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}