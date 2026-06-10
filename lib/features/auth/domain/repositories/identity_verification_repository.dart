import 'package:dartz/dartz.dart';
import '../entities/identity_verification_entity.dart';

abstract class IdentityVerificationRepository {
  Future<Either<String, IdentityVerificationEntity>> submitKtpPhoto({
    required String imagePath,
  });

  Future<Either<String, IdentityVerificationEntity>> submitFaceVerification({
    required String imagePath,
  });
}