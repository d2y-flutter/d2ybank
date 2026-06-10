import 'package:equatable/equatable.dart';
import 'package:d2ybank/shared/base/base_state.dart';

class IdentityVerificationState extends Equatable {
  final StateStatus status;
  final String? ktpPhotoPath;
  final String? facePhotoPath;
  final bool isKtpCompleted;
  final bool isFaceCompleted;
  final String? errorMessage;

  const IdentityVerificationState({
    this.status = StateStatus.initial,
    this.ktpPhotoPath,
    this.facePhotoPath,
    this.isKtpCompleted = false,
    this.isFaceCompleted = false,
    this.errorMessage,
  });

  bool get isCompleted => isKtpCompleted && isFaceCompleted;

  IdentityVerificationState copyWith({
    StateStatus? status,
    String? ktpPhotoPath,
    String? facePhotoPath,
    bool? isKtpCompleted,
    bool? isFaceCompleted,
    String? errorMessage,
    bool clearError = false,
  }) {
    return IdentityVerificationState(
      status: status ?? this.status,
      ktpPhotoPath: ktpPhotoPath ?? this.ktpPhotoPath,
      facePhotoPath: facePhotoPath ?? this.facePhotoPath,
      isKtpCompleted: isKtpCompleted ?? this.isKtpCompleted,
      isFaceCompleted: isFaceCompleted ?? this.isFaceCompleted,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        ktpPhotoPath,
        facePhotoPath,
        isKtpCompleted,
        isFaceCompleted,
        errorMessage,
      ];
}