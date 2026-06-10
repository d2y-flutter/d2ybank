import 'package:d2ybank/shared/base/base_bloc.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/submit_face_verification_usecase.dart';
import '../../../domain/usecases/submit_ktp_photo_usecase.dart';
import 'identity_verification_event.dart';
import 'identity_verification_state.dart';

class IdentityVerificationBloc
    extends BaseBloc<IdentityVerificationEvent, IdentityVerificationState> {
  final SubmitKtpPhotoUseCase submitKtpPhotoUseCase;
  final SubmitFaceVerificationUseCase submitFaceVerificationUseCase;

  IdentityVerificationBloc({
    required this.submitKtpPhotoUseCase,
    required this.submitFaceVerificationUseCase,
  }) : super(const IdentityVerificationState()) {
    on<SubmitKtpPhotoRequested>(_onSubmitKtpPhoto);
    on<SubmitFaceVerificationRequested>(_onSubmitFaceVerification);
    on<ResetIdentityVerificationRequested>(_onReset);
  }

  Future<void> _onSubmitKtpPhoto(
    SubmitKtpPhotoRequested event,
    Emitter<IdentityVerificationState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading, clearError: true));

    final result = await submitKtpPhotoUseCase(
      SubmitKtpPhotoParams(imagePath: event.imagePath),
    );

    result.fold(
      (message) => emit(
        state.copyWith(
          status: StateStatus.failure,
          errorMessage: message,
        ),
      ),
      (entity) => emit(
        state.copyWith(
          status: StateStatus.success,
          ktpPhotoPath: entity.ktpPhotoPath,
          facePhotoPath: entity.facePhotoPath,
          isKtpCompleted: entity.isKtpCompleted,
          isFaceCompleted: entity.isFaceCompleted,
          clearError: true,
        ),
      ),
    );
  }

  Future<void> _onSubmitFaceVerification(
    SubmitFaceVerificationRequested event,
    Emitter<IdentityVerificationState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading, clearError: true));

    final result = await submitFaceVerificationUseCase(
      SubmitFaceVerificationParams(imagePath: event.imagePath),
    );

    result.fold(
      (message) => emit(
        state.copyWith(
          status: StateStatus.failure,
          errorMessage: message,
        ),
      ),
      (entity) => emit(
        state.copyWith(
          status: StateStatus.success,
          ktpPhotoPath: entity.ktpPhotoPath,
          facePhotoPath: entity.facePhotoPath,
          isKtpCompleted: entity.isKtpCompleted,
          isFaceCompleted: entity.isFaceCompleted,
          clearError: true,
        ),
      ),
    );
  }

  Future<void> _onReset(
    ResetIdentityVerificationRequested event,
    Emitter<IdentityVerificationState> emit,
  ) async {
    emit(const IdentityVerificationState());
  }
}