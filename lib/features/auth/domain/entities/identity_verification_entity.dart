import 'package:equatable/equatable.dart';

class IdentityVerificationEntity extends Equatable {
  final String? ktpPhotoPath;
  final String? facePhotoPath;
  final bool isKtpCompleted;
  final bool isFaceCompleted;

  const IdentityVerificationEntity({
    this.ktpPhotoPath,
    this.facePhotoPath,
    this.isKtpCompleted = false,
    this.isFaceCompleted = false,
  });

  bool get isCompleted => isKtpCompleted && isFaceCompleted;

  IdentityVerificationEntity copyWith({
    String? ktpPhotoPath,
    String? facePhotoPath,
    bool? isKtpCompleted,
    bool? isFaceCompleted,
  }) {
    return IdentityVerificationEntity(
      ktpPhotoPath: ktpPhotoPath ?? this.ktpPhotoPath,
      facePhotoPath: facePhotoPath ?? this.facePhotoPath,
      isKtpCompleted: isKtpCompleted ?? this.isKtpCompleted,
      isFaceCompleted: isFaceCompleted ?? this.isFaceCompleted,
    );
  }

  @override
  List<Object?> get props => [
        ktpPhotoPath,
        facePhotoPath,
        isKtpCompleted,
        isFaceCompleted,
      ];
}