import 'package:equatable/equatable.dart';

sealed class IdentityVerificationEvent extends Equatable {
  const IdentityVerificationEvent();

  @override
  List<Object?> get props => [];
}

class SubmitKtpPhotoRequested extends IdentityVerificationEvent {
  final String imagePath;

  const SubmitKtpPhotoRequested({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class SubmitFaceVerificationRequested extends IdentityVerificationEvent {
  final String imagePath;

  const SubmitFaceVerificationRequested({required this.imagePath});

  @override
  List<Object?> get props => [imagePath];
}

class ResetIdentityVerificationRequested extends IdentityVerificationEvent {
  const ResetIdentityVerificationRequested();
}