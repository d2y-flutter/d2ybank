import 'package:dartz/dartz.dart';

import '../../domain/entities/identity_verification_entity.dart';
import '../../domain/repositories/identity_verification_repository.dart';

class IdentityVerificationRepositoryImpl implements IdentityVerificationRepository {
  IdentityVerificationEntity _current = const IdentityVerificationEntity();

  @override
  Future<Either<String, IdentityVerificationEntity>> submitKtpPhoto({
    required String imagePath,
  }) async {
    if (imagePath.trim().isEmpty) {
      return left('Foto KTP tidak valid.');
    }

    await Future<void>.delayed(const Duration(milliseconds: 500));

    _current = _current.copyWith(
      ktpPhotoPath: imagePath,
      isKtpCompleted: true,
    );

    return right(_current);
  }

  @override
  Future<Either<String, IdentityVerificationEntity>> submitFaceVerification({
    required String imagePath,
  }) async {
    if (imagePath.trim().isEmpty) {
      return left('Foto wajah tidak valid.');
    }

    await Future<void>.delayed(const Duration(milliseconds: 500));

    _current = _current.copyWith(
      facePhotoPath: imagePath,
      isFaceCompleted: true,
    );

    return right(_current);
  }
}