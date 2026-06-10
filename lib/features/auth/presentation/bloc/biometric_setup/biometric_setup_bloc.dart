import 'package:d2ybank/shared/base/base_bloc.dart';
import 'package:d2ybank/shared/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/check_biometric_availability_usecase.dart';
import '../../../domain/usecases/enable_biometric_usecase.dart';
import '../../../domain/usecases/skip_biometric_usecase.dart';
import 'biometric_setup_event.dart';
import 'biometric_setup_state.dart';

class BiometricSetupBloc
    extends BaseBloc<BiometricSetupEvent, BiometricSetupState> {
  final CheckBiometricAvailabilityUseCase checkBiometricAvailabilityUseCase;
  final EnableBiometricUseCase enableBiometricUseCase;
  final SkipBiometricUseCase skipBiometricUseCase;

  BiometricSetupBloc({
    required this.checkBiometricAvailabilityUseCase,
    required this.enableBiometricUseCase,
    required this.skipBiometricUseCase,
  }) : super(const BiometricSetupState()) {
    on<BiometricSetupStarted>(_onStarted);
    on<BiometricEnableRequested>(_onEnableRequested);
    on<BiometricSkipRequested>(_onSkipRequested);
  }

  Future<void> _onStarted(
    BiometricSetupStarted event,
    Emitter<BiometricSetupState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading, clearError: true));

    final result = await checkBiometricAvailabilityUseCase();

    result.fold(
      (message) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            isAvailable: false,
            errorMessage: message,
          ),
        );
      },
      (availability) {
        emit(
          state.copyWith(
            status: StateStatus.initial,
            isAvailable: availability.isAvailable,
            biometricLabel: availability.label,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> _onEnableRequested(
    BiometricEnableRequested event,
    Emitter<BiometricSetupState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading, clearError: true));

    final result = await enableBiometricUseCase(
      EnableBiometricParams(
        userId: event.userId,
        deviceId: event.deviceId,
      ),
    );

    result.fold(
      (message) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            errorMessage: message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            isEnabled: true,
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> _onSkipRequested(
    BiometricSkipRequested event,
    Emitter<BiometricSetupState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading, clearError: true));

    final result = await skipBiometricUseCase();

    result.fold(
      (message) {
        emit(
          state.copyWith(
            status: StateStatus.failure,
            errorMessage: message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: StateStatus.success,
            isEnabled: false,
            clearError: true,
          ),
        );
      },
    );
  }
}